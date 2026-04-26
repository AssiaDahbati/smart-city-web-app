<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Job" %>

<%
    List<Job> jobList = (List<Job>) request.getAttribute("jobList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Job Management</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
/* Light RED blurred background */
body{
  font-family:system-ui,Arial;
  min-height:100vh;
  background:
    radial-gradient(900px 500px at 20% 10%, rgba(239,68,68,.22), transparent 60%),
    radial-gradient(900px 500px at 85% 25%, rgba(239,68,68,.14), transparent 60%),
    #f7f7fb;
}

/* Page */
.page-wrap{ padding:30px; }

/* Header */
.page-title{
  font-weight:900;
  color:#111827;
}

/* Toolbar */
.toolbar{
  background:rgba(255,255,255,.75);
  border:1px solid #e5e7eb;
  border-radius:18px;
  padding:16px;
  box-shadow:0 12px 30px rgba(0,0,0,.08);
  backdrop-filter: blur(10px);
}

/* Buttons */
.btn-soft{
  border-radius:14px;
  padding:10px 16px;
  font-weight:900;
  border:0;
}
.btn-jobs{
  background:#ef4444;
  color:#fff;
}
.btn-dark{ border-radius:14px; }

/* Table card */
.card-table{
  background:rgba(255,255,255,.75);
  border:1px solid #e5e7eb;
  border-radius:18px;
  box-shadow:0 16px 40px rgba(0,0,0,.08);
  overflow:hidden;
  backdrop-filter: blur(10px);
}

thead th{
  background:rgba(243,244,246,.9)!important;
  font-weight:900;
}

/* Action buttons */
.action-btn{
  width:40px;height:40px;
  border-radius:14px;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  border:1px solid #e5e7eb;
  background:#fff;
  transition:.15s;
  text-decoration:none;
}
.action-btn:hover{
  transform:translateY(-2px);
  box-shadow:0 10px 20px rgba(0,0,0,.12);
}
.edit-btn{ color:#2563eb; }
.delete-btn{ color:#dc2626; }

/* Search */
.search-input{
  border-radius:14px;
  border:1px solid #e5e7eb;
  padding:12px 14px;
}

/* Job Type badges */
.type-badge{
  font-weight:900;
  border-radius:999px;
  padding:6px 14px;
  font-size:12px;
  display:inline-block;
}
.badge-blue{ background:#3b82f6; color:#fff; }
.badge-green{ background:#22c55e; color:#064e3b; }
.badge-yellow{ background:#facc15; color:#713f12; }
.badge-red{ background:#ef4444; color:#fff; }

/* Apply link */
.link-btn{
  border-radius:14px;
  padding:8px 14px;
  font-weight:900;
  text-decoration:none;
  border:1px solid #e5e7eb;
  background:#fff;
  display:inline-flex;
  align-items:center;
  gap:8px;
}
.link-btn:hover{
  box-shadow:0 10px 20px rgba(0,0,0,.1);
  transform:translateY(-1px);
}
</style>
</head>

<body>

<div class="page-wrap container-fluid">

  <!-- Header -->
  <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
    <div>
      <h2 class="page-title">
        <i class="fa-solid fa-briefcase me-2"></i>Jobs
      </h2>
      <div class="text-muted">Manage job posts (add / edit / delete).</div>
    </div>

    <div class="d-flex gap-2">
      <a href="JobServlet?action=new" class="btn btn-soft btn-jobs">
        <i class="fa-solid fa-plus me-2"></i>Add Job
      </a>
      <a href="admin.jsp" class="btn btn-dark">
        <i class="fa-solid fa-arrow-left me-2"></i>Dashboard
      </a>
    </div>
  </div>

  <!-- Search -->
  <div class="toolbar mb-3">
    <input id="searchBox" type="text" class="form-control search-input"
           placeholder="Search by title, company, location, type, description...">
  </div>

  <!-- Table -->
  <div class="card-table">
    <div class="table-responsive">
      <table class="table table-hover align-middle" id="jobsTable">
        <thead>
          <tr>
            <th style="width:80px;">ID</th>
            <th>Title</th>
            <th>Company</th>
            <th>Location</th>
            <th style="width:150px;">Type</th>
            <th>Description</th>
            <th style="width:170px;">Apply</th>
            <th style="width:140px;" class="text-center">Actions</th>
          </tr>
        </thead>

        <tbody>
        <%
          if (jobList != null && !jobList.isEmpty()) {
            for (Job j : jobList) {

              String type = j.getJobType() == null ? "" : j.getJobType().toLowerCase();
              String badgeClass = "badge-red";
              if (type.equals("full-time")) badgeClass = "badge-blue";
              else if (type.equals("part-time")) badgeClass = "badge-green";
              else if (type.equals("internship")) badgeClass = "badge-yellow";
        %>
          <tr>
            <td><strong><%= j.getId() %></strong></td>
            <td><%= j.getTitle() %></td>
            <td><%= j.getCompany() %></td>
            <td><%= j.getLocation() %></td>

            <td>
              <span class="type-badge <%= badgeClass %>">
                <%= j.getJobType() %>
              </span>
            </td>

            <td><%= j.getDescription() %></td>

            <td>
              <% if (j.getApplyLink()!=null && !j.getApplyLink().isEmpty()) { %>
                <a class="link-btn" href="<%= j.getApplyLink() %>" target="_blank">
                  <i class="fa-solid fa-arrow-up-right-from-square"></i>
                  Apply
                </a>
              <% } else { %>
                <span class="text-muted">No link</span>
              <% } %>
            </td>

            <td class="text-center">
              <a class="action-btn edit-btn"
                 href="JobServlet?action=edit&id=<%= j.getId() %>">
                <i class="fa-solid fa-pen"></i>
              </a>

              <a class="action-btn delete-btn ms-2"
                 href="JobServlet?action=delete&id=<%= j.getId() %>"
                 onclick="return confirm('Delete this job post?');">
                <i class="fa-solid fa-trash"></i>
              </a>
            </td>
          </tr>
        <%
            }
          } else {
        %>
          <tr>
            <td colspan="8" class="text-center text-muted py-5">
              No job posts found.
            </td>
          </tr>
        <%
          }
        %>
        </tbody>
      </table>
    </div>
  </div>

</div>

<script>
  // Search filter
  const searchBox = document.getElementById("searchBox");
  searchBox.addEventListener("keyup", function(){
    const q = this.value.toLowerCase();
    document.querySelectorAll("#jobsTable tbody tr").forEach(r=>{
      r.style.display = r.innerText.toLowerCase().includes(q) ? "" : "none";
    });
  });
</script>

</body>
</html>
