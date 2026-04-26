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
  <title>SmartCity - Jobs</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body::before{
  content:"";
  position:fixed;
  inset:0;
  z-index:-1;
  background:
    radial-gradient(circle at 15% 20%, rgba(239, 68, 68, .35), transparent 55%),
    radial-gradient(circle at 80% 10%, rgba(220, 38, 38, .28), transparent 55%),
    radial-gradient(circle at 50% 90%, rgba(248, 113, 113, .20), transparent 55%),
    linear-gradient(180deg, #fff7f7 0%, #fef2f2 50%, #fff7f7 100%);
  filter: blur(18px);
  transform: scale(1.08); font-family:system-ui,Arial; }
    .topnav{ background:#fff; border-bottom:1px solid #e5e7eb; }
    .topnav a{ font-weight:800; }

    .page{ padding:26px; }
    .title{ font-weight:900; color:#111827; margin:0; }
    .sub{ color:#6b7280; font-weight:700; }

    .searchbox{
      background:#fff; border:1px solid #e5e7eb; border-radius:16px;
      padding:14px; box-shadow:0 12px 22px rgba(0,0,0,.06);
      margin:16px 0 18px;
    }
    .search-input{
      border-radius:14px; border:1px solid #e5e7eb; padding:12px 14px;
    }

    .cardx{
      background:#fff; border:1px solid #e5e7eb; border-radius:18px;
      box-shadow:0 12px 22px rgba(0,0,0,.06);
      height:100%;
      transition:.18s;
    }
    .cardx:hover{ transform: translateY(-3px); box-shadow:0 18px 32px rgba(0,0,0,.10); }

    .job-title{ font-weight:900; color:#111827; }
    .muted{ color:#6b7280; font-weight:700; }

  
    .type-badge{
      font-weight:900; border-radius:999px; padding:6px 10px; font-size:12px; display:inline-block;
    }
    .t-red{ background:#fee2e2; color:#991b1b; }
    .t-blue{ background:#dbeafe; color:#1e40af; }
    .t-green{ background:#dcfce7; color:#166534; }
    .t-yellow{ background:#fef3c7; color:#92400e; }

    .apply-btn{
      border-radius:12px; font-weight:900; padding:10px 12px;
      background:#ef4444; color:#fff; border:0;
      text-decoration:none; display:inline-flex; align-items:center; gap:8px;
    }
    .apply-btn:hover{ filter:brightness(.95); color:#fff; }
  </style>
</head>

<body>

<nav class="navbar topnav navbar-expand-lg">
  <div class="container">
    <a class="navbar-brand fw-black" href="<%= request.getContextPath() %>/HomeServlet">
      <i class="fa-solid fa-city me-2"></i>SmartCity
    </a>

    <div class="ms-auto d-flex gap-2">
      <a class="btn btn-outline-dark" href="<%= request.getContextPath() %>/HomeServlet"><i class="fa-solid fa-house me-2"></i>Home</a>
      <a class="btn btn-dark" href="login.jsp"><i class="fa-solid fa-user-shield me-2"></i>Admin</a>
    </div>
  </div>
</nav>

<div class="container page">

  <h2 class="title"><i class="fa-solid fa-briefcase me-2"></i>Jobs</h2>
  <div class="sub">Find job opportunities posted by the administration.</div>

  <div class="searchbox">
    <div class="input-group">
      <span class="input-group-text bg-white" style="border:1px solid #e5e7eb; border-radius:14px 0 0 14px;">
        <i class="fa-solid fa-magnifying-glass"></i>
      </span>
      <input id="searchBox" class="form-control search-input"
             placeholder="Search by title, company, location, type..."
             style="border-radius:0 14px 14px 0;">
    </div>
  </div>

  <div class="row g-3">
    <%
      if (jobList != null && !jobList.isEmpty()) {
        for (Job j : jobList) {
          String type = (j.getJobType() == null) ? "" : j.getJobType().trim().toLowerCase();

          String cls = "t-blue"; // default
          if (type.contains("full")) cls = "t-green";
          else if (type.contains("part")) cls = "t-blue";
          else if (type.contains("intern")) cls = "t-yellow";
          else cls = "t-red"; // other

          String link = j.getApplyLink();
          boolean hasLink = (link != null && !link.trim().isEmpty());
    %>
      <div class="col-12 col-md-6 col-lg-4 col-xl-3 job-card">
        <div class="cardx p-3">
          <div class="d-flex justify-content-between align-items-start">
            <div>
              <div class="job-title"><%= j.getTitle() %></div>
              <div class="muted"><%= j.getCompany() %></div>
            </div>
            <span class="type-badge <%= cls %>"><%= j.getJobType() %></span>
          </div>

          <div class="muted mt-2">
            <i class="fa-solid fa-location-dot me-2"></i><%= j.getLocation() %>
          </div>

          <div class="mt-2" style="color:#374151;">
            <%= j.getDescription() %>
          </div>

          <div class="mt-3">
            <% if (hasLink) { %>
              <a class="apply-btn" href="<%= link %>" target="_blank">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Apply
              </a>
            <% } else { %>
              <span class="text-muted">No apply link</span>
            <% } %>
          </div>
        </div>
      </div>
    <%
        }
      } else {
    %>
      <div class="col-12">
        <div class="alert alert-light border">No job posts found.</div>
      </div>
    <%
      }
    %>
  </div>

</div>

<script>
  const searchBox = document.getElementById("searchBox");
  searchBox.addEventListener("keyup", function(){
    const q = this.value.toLowerCase();
    document.querySelectorAll(".job-card").forEach(c=>{
      c.style.display = c.innerText.toLowerCase().includes(q) ? "" : "none";
    });
  });
</script>

</body>
</html>
