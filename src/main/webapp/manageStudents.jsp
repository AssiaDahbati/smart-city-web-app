<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="models.Student" %>

<%
  List<Student> students = (List<Student>) request.getAttribute("students");
  if (students == null) students = new ArrayList<>();

  String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Educational Places - Admin</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
 body{
  font-family: system-ui, Arial;
  min-height: 100vh;
  margin: 0;
  background:
    radial-gradient(circle at 15% 20%, rgba(253, 224, 71, .45), transparent 55%),
    radial-gradient(circle at 80% 10%, rgba(250, 204, 21, .35), transparent 55%),
    radial-gradient(circle at 50% 90%, rgba(254, 240, 138, .30), transparent 55%),
    linear-gradient(180deg, #fffde7 0%, #fef9c3 50%, #fffde7 100%);
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
      font-weight:900;             /* softer than 1000 */
      margin:0;
      font-size:40px;
      display:flex;
      gap:12px;
      align-items:center;
      letter-spacing:-.2px;
    }
    .sub{ color:#6b7280; font-weight:700; margin-top:6px; }

    .btnx{
      border:0;
      border-radius:14px;
      padding:12px 16px;
      font-weight:800;
      text-decoration:none;
      display:inline-flex;
      align-items:center;
      gap:10px;
      transition:.15s;
    }
    .btn-add{ background:#3b82f6; color:#fff; }
    .btn-add:hover{ filter:brightness(.97); color:#fff; }
    .btn-back{ background:#111827; color:#fff; }
    .btn-back:hover{ filter:brightness(.97); color:#fff; }

    .searchbar{
      display:flex;
      gap:14px;
      align-items:center;
      justify-content:space-between;
      padding:16px;
      margin:18px 0;
    }
    .searchbar .input-group{ max-width:560px; }
    .searchbar .form-control{ font-weight:600; }
    .tip{
      font-weight:700;
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
      font-weight:800;
      border-bottom:1px solid #e5e7eb !important;
      padding:14px 12px !important;
    }
    tbody td{
      vertical-align:middle;
      font-weight:600;            /* IMPORTANT: makes rows NOT bold */
      padding:14px 12px !important;
      color:#111827;
    }
    tbody tr{ border-top:1px solid #eef2f7; }
    tbody tr:hover{ background:rgba(17,24,39,.02); }

    .act{
      display:flex; gap:10px; justify-content:flex-end;
    }
    .iconbtn{
      width:42px; height:42px;
      border-radius:14px;
      display:flex;
      align-items:center;
      justify-content:center;
      text-decoration:none;
      border:1px solid #e5e7eb;
      background:#fff;
      transition:.15s;
    }
    .iconbtn:hover{ background:#f3f4f6; }
    .iconbtn.edit{ color:#2563eb; }
    .iconbtn.del{ color:#dc2626; }

    .thumb{
      width:72px;
      height:54px;
      object-fit:cover;
      border-radius:12px;
      border:1px solid #e5e7eb;
      background:#f3f4f6;
      display:block;
    }
    .muted{ color:#6b7280; font-weight:700; }
  </style>
</head>

<body>
<div class="blur-bg"></div>

<div class="wrap">

  <div class="header">
    <div>
      <h1><i class="fa-solid fa-school"></i>Educational Places</h1>
      <div class="sub">Manage educational places (add / edit / delete).</div>
    </div>

    <div class="d-flex gap-2">
      <a class="btnx btn-add" href="<%= ctx %>/StudentServlet?action=new">
        <i class="fa-solid fa-plus"></i> Add Place
      </a>
      <a class="btnx btn-back" href="<%= ctx %>/admin.jsp">
        <i class="fa-solid fa-arrow-left"></i> Back Dashboard
      </a>
    </div>
  </div>

  <div class="glass searchbar">
    <div class="input-group">
      <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass"></i></span>
      <input id="q" class="form-control"
             placeholder="Search by place name, location, type/category, level, email...">
    </div>
    <div class="tip">
      <i class="fa-solid fa-circle-info"></i>
      Tip: Click <i class="fa-solid fa-pen-to-square"></i> to edit, <i class="fa-solid fa-trash"></i> to delete.
    </div>
  </div>

  <div class="glass p-0 overflow-hidden">
    <div class="table-responsive">
      <table class="table table-borderless align-middle mb-0" id="tbl">
        <thead>
          <tr>
            <th style="width:70px;">ID</th>
            <th style="width:120px;">Image</th>
            <th>Place Name</th>
            <th>Location</th>
            <th>Type / Category</th>
            <th>Level</th>
            <th>Contact Email</th>
            <th class="text-end" style="width:150px;">Actions</th>
          </tr>
        </thead>

        <tbody>
        <% if(students.isEmpty()){ %>
          <tr>
            <td colspan="8" class="text-center text-muted fw-bold py-5">
              No educational places found. Click <b>Add Place</b> to create one.
            </td>
          </tr>
        <% } %>

        <% for(Student s : students){ 
             String img = s.getImageUrl();
             boolean hasImg = (img != null && !img.trim().isEmpty());
        %>
          <tr class="r">
            <td><%= s.getId() %></td>

            <td>
              <% if(hasImg){ %>
                <img class="thumb" src="<%= img %>" alt="place">
              <% } else { %>
                <span class="muted">—</span>
              <% } %>
            </td>

            <td><%= s.getFullName() %></td>
            <td><%= s.getUniversity() %></td>
            <td><%= s.getMajor() %></td>
            <td><%= s.getLevel() %></td>
            <td><%= s.getEmail() %></td>

            <td class="text-end">
              <div class="act">
                <a class="iconbtn edit" href="<%= ctx %>/StudentServlet?action=edit&id=<%= s.getId() %>">
                  <i class="fa-solid fa-pen-to-square"></i>
                </a>
                <a class="iconbtn del"
                   href="<%= ctx %>/StudentServlet?action=delete&id=<%= s.getId() %>"
                   onclick="return confirm('Delete this place?');">
                  <i class="fa-solid fa-trash"></i>
                </a>
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
