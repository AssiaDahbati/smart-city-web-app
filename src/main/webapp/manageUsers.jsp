<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="models.User" %>

<%
  String ctx = request.getContextPath();

  List<User> users = (List<User>) request.getAttribute("users");
  if (users == null) users = new ArrayList<>();

  String q = request.getParameter("q");
  if (q == null) q = "";
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Manage Users - Admin</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body{
      font-family:system-ui, Arial, sans-serif;
      background:
        radial-gradient(circle at 12% 18%, rgba(59,130,246,.18), transparent 45%),
        radial-gradient(circle at 80% 20%, rgba(34,197,94,.10), transparent 45%),
        radial-gradient(circle at 30% 90%, rgba(245,158,11,.12), transparent 45%),
        #f6f7fb;
      min-height:100vh;
      color:#111827;
    }
    .wrap{ max-width:1200px; margin:26px auto; padding:0 16px; }

    .glass{
      background: rgba(255,255,255,.92);
      border:1px solid rgba(229,231,235,.9);
      border-radius:18px;
      box-shadow:0 16px 34px rgba(0,0,0,.08);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
    }

    .header{
      display:flex;
      align-items:flex-start;
      justify-content:space-between;
      gap:14px;
      margin-bottom:14px;
    }
    h1{
      font-weight:1000;
      margin:0;
      font-size:42px;
      display:flex;
      gap:12px;
      align-items:center;
    }
    .sub{ color:#6b7280; font-weight:700; margin-top:4px; }

    .btnx{
      border:0;
      border-radius:14px;
      padding:12px 16px;
      font-weight:900;
      text-decoration:none;
      display:inline-flex;
      align-items:center;
      gap:10px;
    }
    .btn-back{ background:#111827; color:#fff; }
    .btn-back:hover{ filter:brightness(.96); color:#fff; }

    .searchbar{
      display:flex;
      gap:14px;
      align-items:center;
      justify-content:space-between;
      padding:16px;
      margin:18px 0;
    }
    .searchbar .input-group{ max-width:560px; }
    .tip{
      font-weight:900;
      color:#1d4ed8;
      background:#eff6ff;
      border:1px solid #dbeafe;
      padding:10px 14px;
      border-radius:999px;
      display:flex;
      align-items:center;
      gap:10px;
      white-space:nowrap;
    }

    thead th{
      background:#f3f4f6;
      font-weight:900;
      border-bottom:1px solid #e5e7eb !important;
    }
    tbody td{ vertical-align:middle; font-weight:700; }
    tbody tr{ border-top:1px solid #eef2f7; }

    .badge-status{
      font-size:12px;
      font-weight:900;
      padding:6px 10px;
      border-radius:999px;
      border:1px solid rgba(0,0,0,.08);
      display:inline-flex;
      gap:6px;
      align-items:center;
    }
    .approved{ background:rgba(34,197,94,.12); color:#166534; border-color:rgba(34,197,94,.22); }
    .pending{ background:rgba(245,158,11,.14); color:#92400e; border-color:rgba(245,158,11,.25); }

    .act{ display:flex; gap:10px; justify-content:flex-end; flex-wrap:wrap; }
    .iconbtn{
      border-radius:12px;
      padding:10px 12px;
      text-decoration:none;
      border:1px solid #e5e7eb;
      background:#fff;
      font-weight:900;
      display:inline-flex;
      align-items:center;
      gap:8px;
    }
    .iconbtn:hover{ background:#f3f4f6; }
    .iconbtn.approve{ color:#166534; }
    .iconbtn.disable{ color:#b45309; }
    .iconbtn.del{ color:#dc2626; }
  </style>
</head>

<body>
<div class="wrap">

  <div class="header">
    <div>
      <h1><i class="fa-solid fa-users-gear"></i>Manage Users</h1>
      <div class="sub">Approve or disable visitor accounts (registration needs admin approval).</div>
    </div>

    <div class="d-flex gap-2">
      <a class="btnx btn-back" href="<%= ctx %>/admin.jsp">
        <i class="fa-solid fa-arrow-left"></i> Back Dashboard
      </a>
    </div>
  </div>

  <div class="glass searchbar">
    <div class="input-group">
      <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass"></i></span>
      <input id="q" class="form-control fw-bold"
             value="<%= q %>"
             placeholder="Search by username, email, role, status...">
    </div>
    <div class="tip">
      <i class="fa-solid fa-circle-info"></i>
      Tip: Approve = allow login, Disable = block login.
    </div>
  </div>

  <div class="glass p-0 overflow-hidden">
    <div class="table-responsive">
      <table class="table table-borderless align-middle mb-0" id="tbl">
        <thead>
          <tr>
            <th style="width:70px;">ID</th>
            <th>Username</th>
            <th>Email</th>
            <th style="width:140px;">Role</th>
            <th style="width:160px;">Status</th>
            <th class="text-end" style="width:260px;">Actions</th>
          </tr>
        </thead>
        <tbody>
        <% if(users.isEmpty()){ %>
          <tr>
            <td colspan="6" class="text-center text-muted fw-bold py-5">No users found.</td>
          </tr>
        <% } %>

        <% for(User u : users){
             String st = (u.getStatus() == null ? "" : u.getStatus().toUpperCase());
             boolean approved = "APPROVED".equals(st);
        %>
          <tr class="r">
            <td><%= u.getId() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getEmail() %></td>
            <td><span class="fw-bold"><%= u.getRole() %></span></td>
            <td>
              <% if (approved) { %>
                <span class="badge-status approved"><i class="fa-solid fa-check"></i> APPROVED</span>
              <% } else { %>
                <span class="badge-status pending"><i class="fa-solid fa-clock"></i> PENDING</span>
              <% } %>
            </td>

            <td class="text-end">
              <div class="act">
                <%-- Approve/Disable only for normal users --%>
                <% if (!"ADMIN".equalsIgnoreCase(u.getRole())) { %>

                  <% if (!approved) { %>
                    <a class="iconbtn approve"
                       href="<%= ctx %>/AdminUserServlet?action=approve&id=<%= u.getId() %>"
                       onclick="return confirm('Approve this user?');">
                      <i class="fa-solid fa-check"></i> Approve
                    </a>
                  <% } else { %>
                    <a class="iconbtn disable"
                       href="<%= ctx %>/AdminUserServlet?action=reject&id=<%= u.getId() %>"
                       onclick="return confirm('Disable this user (set to PENDING)?');">
                      <i class="fa-solid fa-ban"></i> Disable
                    </a>
                  <% } %>

                  <a class="iconbtn del"
                     href="<%= ctx %>/AdminUserServlet?action=delete&id=<%= u.getId() %>"
                     onclick="return confirm('Delete this user permanently?');">
                    <i class="fa-solid fa-trash"></i> Delete
                  </a>

                <% } else { %>
                  <span class="text-muted fw-bold">Admin account</span>
                <% } %>
              </div>
            </td>
          </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>

</div>

<script>
  const q = document.getElementById("q");
  q.addEventListener("keyup", () => {
    const s = q.value.toLowerCase();
    document.querySelectorAll("#tbl tbody .r").forEach(row=>{
      row.style.display = row.innerText.toLowerCase().includes(s) ? "" : "none";
    });
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
