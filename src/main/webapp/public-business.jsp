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
  <title>SmartCity - Business</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
 body::before{
  content:"";
  position:fixed;
  inset:0;
  z-index:-1;
  background:
    radial-gradient(circle at 15% 20%, rgba(34, 197, 94, .35), transparent 55%),   /* green */
    radial-gradient(circle at 80% 10%, rgba(250, 204, 21, .30), transparent 55%),  /* yellow */
    radial-gradient(circle at 50% 90%, rgba(132, 204, 22, .22), transparent 55%),  /* lime */
    linear-gradient(180deg, #f7fdf7 0%, #fefce8 50%, #f7fdf7 100%);
  
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

    .pill{
      display:inline-block; font-size:12px; font-weight:900;
      padding:6px 10px; border-radius:999px;
      background:#dcfce7; color:#166534;
    }
    .name{ font-weight:900; color:#111827; }
    .muted{ color:#6b7280; font-weight:700; }
    .email{
      display:inline-flex; align-items:center; gap:8px;
      font-weight:900; text-decoration:none;
      color:#166534;
      background:#dcfce7; border:1px solid #bbf7d0;
      padding:8px 10px; border-radius:12px;
    }
    .email:hover{ filter:brightness(.97); }
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

  <h2 class="title"><i class="fa-solid fa-building me-2"></i>Business</h2>
  <div class="sub">Discover local businesses and services.</div>

  <div class="searchbox">
    <div class="input-group">
      <span class="input-group-text bg-white" style="border:1px solid #e5e7eb; border-radius:14px 0 0 14px;">
        <i class="fa-solid fa-magnifying-glass"></i>
      </span>
      <input id="searchBox" class="form-control search-input"
             placeholder="Search by name, category, location, description..."
             style="border-radius:0 14px 14px 0;">
    </div>
  </div>

  <div class="row g-3">
    <%
      if (businessList != null && !businessList.isEmpty()) {
        for (Business b : businessList) {
          String email = b.getContactEmail();
          boolean hasEmail = (email != null && !email.trim().isEmpty());
    %>
      <div class="col-12 col-md-6 col-lg-4 col-xl-3 business-card">
        <div class="cardx p-3">
          <span class="pill">BUSINESS</span>

          <div class="name mt-2"><%= b.getName() %></div>
          <div class="muted"><%= b.getCategory() %></div>

          <div class="muted mt-2">
            <i class="fa-solid fa-location-dot me-2"></i><%= b.getLocation() %>
          </div>

          <div class="mt-2" style="color:#374151;">
            <%= b.getDescription() %>
          </div>

          <div class="mt-3">
            <% if (hasEmail) { %>
              <a class="email" href="mailto:<%= email %>">
                <i class="fa-solid fa-envelope"></i> <%= email %>
              </a>
            <% } else { %>
              <span class="text-muted">No contact email</span>
            <% } %>
          </div>
        </div>
      </div>
    <%
        }
      } else {
    %>
      <div class="col-12">
        <div class="alert alert-light border">No businesses found.</div>
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
    document.querySelectorAll(".business-card").forEach(c=>{
      c.style.display = c.innerText.toLowerCase().includes(q) ? "" : "none";
    });
  });
</script>

</body>
</html>
