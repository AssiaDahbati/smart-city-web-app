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
  <title>SmartCity - Tourism</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body{
      font-family:system-ui,Arial;
      margin:0;
      min-height:100vh;
      background:#f6f7fb;
      position:relative;
      overflow-x:hidden;
    }

    /* BLUE BLUR BACKGROUND */
    .blur-bg{
      position:fixed;
      inset:0;
      z-index:-1;
      background:
        radial-gradient(circle at 15% 20%, rgba(59,130,246,.35), transparent 55%),
        radial-gradient(circle at 80% 10%, rgba(37,99,235,.28), transparent 55%),
        radial-gradient(circle at 50% 90%, rgba(99,102,241,.20), transparent 55%),
        linear-gradient(180deg, #f7fbff 0%, #f6f7fb 50%, #f7fbff 100%);
      filter: blur(18px);
      transform: scale(1.08);
    }

    /* Top nav */
    .topnav{
      background:rgba(255,255,255,.85);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border-bottom:1px solid rgba(229,231,235,.8);
    }
    .topnav a{ font-weight:800; }

    .page{ padding:26px; }
    .title{ font-weight:900; color:#111827; margin:0; }
    .sub{ color:#6b7280; font-weight:700; }

    /* Search box */
    .searchbox{
      background:rgba(255,255,255,.85);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border:1px solid rgba(229,231,235,.9);
      border-radius:16px;
      padding:14px;
      box-shadow:0 12px 22px rgba(0,0,0,.06);
      margin:16px 0 10px;
    }
    .search-input{
      border-radius:14px;
      border:1px solid #e5e7eb;
      padding:12px 14px;
      background:rgba(255,255,255,.95);
    }

    /* Quote under search */
    .quote{
      margin: 0 0 18px;
      padding: 12px 14px;
      border-radius: 14px;
      background: rgba(59,130,246,.10);
      border: 1px solid rgba(59,130,246,.18);
      color:#1e3a8a;
      font-weight: 800;
      display:flex;
      gap:10px;
      align-items:flex-start;
    }
    .quote i{
      margin-top:2px;
      color:#2563eb;
      font-size:16px;
    }

    /* Cards */
    .cardx{
      background:rgba(255,255,255,.88);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border:1px solid rgba(229,231,235,.9);
      border-radius:18px;
      box-shadow:0 12px 22px rgba(0,0,0,.06);
      overflow:hidden;
      height:100%;
      transition:.18s;
    }
    .cardx:hover{
      transform: translateY(-3px);
      box-shadow:0 18px 32px rgba(0,0,0,.10);
    }

    .thumb{
      width:100%;
      height:180px;
      object-fit:cover;
      background:#f3f4f6;
    }

    .pill{
      display:inline-block;
      font-size:12px;
      font-weight:900;
      padding:6px 10px;
      border-radius:999px;
      background:#fef3c7;
      color:#92400e;
    }

    .place{ font-weight:900; color:#111827; }
    .loc{ color:#6b7280; font-weight:700; }
    .desc{ color:#374151; }
  </style>
</head>

<body>

<div class="blur-bg"></div>

<nav class="navbar topnav navbar-expand-lg">
  <div class="container">
    <a class="navbar-brand fw-black" href="<%= request.getContextPath() %>/HomeServlet">
      <i class="fa-solid fa-city me-2"></i>SmartCity
    </a>

    <div class="ms-auto d-flex gap-2">
      <a class="btn btn-outline-dark" href="<%= request.getContextPath() %>/HomeServlet">
        <i class="fa-solid fa-house me-2"></i>Home
      </a>
      <a class="btn btn-dark" href="login.jsp">
        <i class="fa-solid fa-user-shield me-2"></i>Admin
      </a>
    </div>
  </div>
</nav>

<div class="container page">

  <div class="d-flex justify-content-between align-items-end flex-wrap gap-2">
    <div>
      <h2 class="title"><i class="fa-solid fa-umbrella-beach me-2"></i>Tourism</h2>
      <div class="sub">Explore places added by the administration.</div>
    </div>
  </div>

  <!-- Search -->
  <div class="searchbox">
    <div class="input-group">
      <span class="input-group-text bg-white" style="border:1px solid #e5e7eb; border-radius:14px 0 0 14px;">
        <i class="fa-solid fa-magnifying-glass"></i>
      </span>
      <input id="searchBox" class="form-control search-input"
             placeholder="Search by name, location, description..."
             style="border-radius:0 14px 14px 0;">
    </div>
  </div>

  <!-- Quote under search -->
  <div class="quote">
    <i class="fa-solid fa-hand-holding-heart"></i>
    <div>
      <div>“A smart city starts with caring citizens.”</div>
      <div style="font-weight:700; color:#1d4ed8;">
        Keep our streets clean, respect public spaces, and protect our heritage.
      </div>
    </div>
  </div>

  <!-- Cards -->
  <div class="row g-3" id="cardsWrap">
    <%
      if (tourismList != null && !tourismList.isEmpty()) {
        for (Tourism t : tourismList) {
          String img = t.getImageUrl();
          boolean hasImg = (img != null && !img.trim().isEmpty());
    %>
      <div class="col-12 col-md-6 col-lg-4 col-xl-3 tourism-card">
        <div class="cardx">
          <% if (hasImg) { %>
            <img class="thumb" src="<%= img %>" alt="tourism image">
          <% } else { %>
            <div class="thumb d-flex align-items-center justify-content-center text-muted fw-bold">
              NO IMAGE
            </div>
          <% } %>

          <div class="p-3">
            <span class="pill">TOURISM</span>
            <div class="place mt-2"><%= t.getName() %></div>
            <div class="loc"><i class="fa-solid fa-location-dot me-2"></i><%= t.getLocation() %></div>
            <div class="desc mt-2"><%= t.getDescription() %></div>
          </div>
        </div>
      </div>
    <%
        }
      } else {
    %>
      <div class="col-12">
        <div class="alert alert-light border">No tourism places found.</div>
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
    document.querySelectorAll(".tourism-card").forEach(c=>{
      c.style.display = c.innerText.toLowerCase().includes(q) ? "" : "none";
    });
  });
</script>

</body>
</html>
