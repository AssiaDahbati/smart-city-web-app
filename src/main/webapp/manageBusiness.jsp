<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Business" %>

<%
    List<Business> businessList = (List<Business>) request.getAttribute("businessList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Business Management</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
/* Light GREEN blurred background */
body{
  font-family:system-ui,Arial;
  min-height:100vh;
  background:
    radial-gradient(900px 500px at 20% 10%, rgba(34,197,94,.22), transparent 60%),
    radial-gradient(900px 500px at 85% 25%, rgba(34,197,94,.14), transparent 60%),
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
.btn-business{
  background:#22c55e;
  color:#064e3b;
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

/* Category badge */
.cat-badge{
  font-weight:900;
  border-radius:999px;
  padding:6px 14px;
  font-size:12px;
  display:inline-block;
  background:#dcfce7;
  color:#166534;
  border:1px solid #bbf7d0;
}

/* Email pill */
.email-pill{
  display:inline-flex;
  align-items:center;
  gap:8px;
  border:1px solid #e5e7eb;
  background:#fff;
  padding:8px 12px;
  border-radius:999px;
  font-weight:800;
  text-decoration:none;
  color:#111827;
}
.email-pill:hover{
  transform:translateY(-1px);
  box-shadow:0 10px 20px rgba(0,0,0,.08);
}
</style>
</head>

<body>

<div class="page-wrap container-fluid">

  <!-- Header -->
  <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
    <div>
      <h2 class="page-title">
        <i class="fa-solid fa-building me-2"></i>Business
      </h2>
      <div class="text-muted">Manage businesses (add / edit / delete).</div>
    </div>

    <div class="d-flex gap-2">
      <a href="BusinessServlet?action=new" class="btn btn-soft btn-business">
        <i class="fa-solid fa-plus me-2"></i>Add Business
      </a>
      <a href="admin.jsp" class="btn btn-dark">
        <i class="fa-solid fa-arrow-left me-2"></i>Dashboard
      </a>
    </div>
  </div>

  <!-- Search -->
  <div class="toolbar mb-3">
    <input id="searchBox" type="text" class="form-control search-input"
           placeholder="Search by name, category, location, description, email...">
  </div>

  <!-- Table -->
  <div class="card-table">
    <div class="table-responsive">
      <table class="table table-hover align-middle" id="businessTable">
        <thead>
          <tr>
            <th style="width:80px;">ID</th>
            <th>Name</th>
            <th style="width:170px;">Category</th>
            <th>Location</th>
            <th>Description</th>
            <th style="width:220px;">Email</th>
            <th style="width:140px;" class="text-center">Actions</th>
          </tr>
        </thead>

        <tbody>
        <%
          if (businessList != null && !businessList.isEmpty()) {
            for (Business b : businessList) {

              String email = b.getContactEmail();
              boolean hasEmail = (email != null && !email.trim().isEmpty());
        %>
          <tr>
            <td><strong><%= b.getId() %></strong></td>
            <td><%= b.getName() %></td>

            <td>
              <span class="cat-badge"><%= b.getCategory() %></span>
            </td>

            <td><%= b.getLocation() %></td>
            <td><%= b.getDescription() %></td>

            <td>
              <% if (hasEmail) { %>
                <a class="email-pill" href="mailto:<%= email %>">
                  <i class="fa-solid fa-envelope"></i> <%= email %>
                </a>
              <% } else { %>
                <span class="text-muted">No email</span>
              <% } %>
            </td>

            <td class="text-center">
              <a class="action-btn edit-btn"
                 href="BusinessServlet?action=edit&id=<%= b.getId() %>">
                <i class="fa-solid fa-pen"></i>
              </a>

              <a class="action-btn delete-btn ms-2"
                 href="BusinessServlet?action=delete&id=<%= b.getId() %>"
                 onclick="return confirm('Delete this business?');">
                <i class="fa-solid fa-trash"></i>
              </a>
            </td>
          </tr>
        <%
            }
          } else {
        %>
          <tr>
            <td colspan="7" class="text-center text-muted py-5">
              No businesses found.
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
    document.querySelectorAll("#businessTable tbody tr").forEach(r=>{
      r.style.display = r.innerText.toLowerCase().includes(q) ? "" : "none";
    });
  });
</script>

</body>
</html>
