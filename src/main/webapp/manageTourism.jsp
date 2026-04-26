<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Tourism" %>

<%
    List<Tourism> tourismList = (List<Tourism>) request.getAttribute("tourismList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tourism Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body{ background:
        radial-gradient(circle at 10% 10%, rgba(59,130,246,.16), transparent 45%),
        radial-gradient(circle at 80% 20%, rgba(34,197,94,.10), transparent 45%),
        radial-gradient(circle at 20% 90%, rgba(245,158,11,.10), transparent 45%),
        #f6f7fb;; font-family:system-ui,Arial; }

.page-wrap{ padding:28px; }

.page-title{
  font-weight:900;
  color:#111827;
}

.toolbar{
  background:#fff;
  border:1px solid #e5e7eb;
  border-radius:16px;
  padding:16px;
  box-shadow:0 12px 22px rgba(0,0,0,.06);
}

.btn-soft{
  border:0;
  border-radius:12px;
  padding:10px 14px;
  font-weight:800;
}
.btn-tourism{
  background:#f59e0b;
  color:#1f2937;
}

.card-table{
  background:#fff;
  border:1px solid #e5e7eb;
  border-radius:16px;
  overflow:hidden;
  box-shadow:0 12px 22px rgba(0,0,0,.06);
}

thead th{
  background:#f3f4f6 !important;
  font-weight:900;
}

.action-btn{
  width:38px;height:38px;
  border-radius:12px;
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
  box-shadow:0 10px 18px rgba(0,0,0,.1);
}
.edit-btn{ color:#2563eb; }
.delete-btn{ color:#dc2626; }

.search-input{
  border-radius:12px;
  border:1px solid #e5e7eb;
  padding:10px 12px;
}

/* Thumbnail */
.thumb{
  width:70px;
  height:50px;
  object-fit:cover;
  border-radius:12px;
  border:1px solid #e5e7eb;
  background:#f3f4f6;
}
.noimg{
  width:70px;
  height:50px;
  border-radius:12px;
  border:1px dashed #d1d5db;
  background:#f9fafb;
  display:flex;
  align-items:center;
  justify-content:center;
  color:#9ca3af;
  font-size:12px;
  font-weight:800;
}
</style>
</head>

<body>

<div class="page-wrap container-fluid">


  <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
    <div>
      <h2 class="page-title">
        <i class="fa-solid fa-umbrella-beach me-2"></i>Tourism
      </h2>
      <div class="text-muted">Manage tourism places (add / edit / delete).</div>
    </div>

    <div class="d-flex gap-2">
      <a href="TourismServlet?action=new" class="btn btn-soft btn-tourism">
        <i class="fa-solid fa-plus me-2"></i>Add Place
      </a>
      <a href="admin.jsp" class="btn btn-soft" style="background:#111827;color:#fff;">
        <i class="fa-solid fa-arrow-left me-2"></i>Dashboard
      </a>
    </div>
  </div>

  <!-- Search -->
  <div class="toolbar mb-3">
    <input id="searchBox" type="text" class="form-control search-input"
           placeholder="Search by name, location, description...">
  </div>

  <!-- Table -->
  <div class="card-table">
    <div class="table-responsive">
      <table class="table table-hover align-middle" id="tourismTable">
        <thead>
          <tr>
            <th style="width:80px;">ID</th>
            <th style="width:120px;">Image</th>
            <th>Name</th>
            <th>Location</th>
            <th>Description</th>
            <th style="width:130px;" class="text-center">Actions</th>
          </tr>
        </thead>

        <tbody>
        <%
          if (tourismList != null && !tourismList.isEmpty()) {
            for (Tourism t : tourismList) {

              String img = t.getImageUrl();
              boolean hasImg = (img != null && !img.trim().isEmpty());
        %>
          <tr>
            <td><strong><%= t.getId() %></strong></td>

            <td>
              <% if (hasImg) { %>
                <a href="<%= img %>" target="_blank" title="Open image">
                  <img class="thumb" src="<%= img %>" alt="tourism image">
                </a>
              <% } else { %>
                <div class="noimg">NO IMG</div>
              <% } %>
            </td>

            <td><%= t.getName() %></td>
            <td><%= t.getLocation() %></td>
            <td><%= t.getDescription() %></td>

            <td class="text-center">
              <a class="action-btn edit-btn"
                 href="TourismServlet?action=edit&id=<%= t.getId() %>">
                <i class="fa-solid fa-pen"></i>
              </a>
              <a class="action-btn delete-btn ms-2"
                 href="TourismServlet?action=delete&id=<%= t.getId() %>"
                 onclick="return confirm('Delete this place?');">
                <i class="fa-solid fa-trash"></i>
              </a>
            </td>
          </tr>
        <%
            }
          } else {
        %>
          <tr>
            <td colspan="6" class="text-center text-muted py-5">
              No tourism places found.
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
    document.querySelectorAll("#tourismTable tbody tr").forEach(r=>{
      r.style.display = r.innerText.toLowerCase().includes(q) ? "" : "none";
    });
  });
</script>

</body>
</html>

