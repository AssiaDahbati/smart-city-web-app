<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="models.Student" %>

<%
  String ctx = request.getContextPath();
  List<Student> eduList = (List<Student>) request.getAttribute("eduList");
  if (eduList == null) eduList = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>SmartCity - Educational Places</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body{
      font-family: system-ui, Arial, sans-serif;
      margin:0;
      min-height:100vh;
      color:#111827;
      background:#f7f7fb;
      overflow-x:hidden;
    }

    .blur-bg{
      position:fixed;
      inset:0;
      z-index:-1;
     background:
    radial-gradient(circle at 15% 20%, rgba(249, 115, 22, .35), transparent 55%),   /* orange */
    radial-gradient(circle at 80% 10%, rgba(251, 146, 60, .30), transparent 55%),   /* amber */
    radial-gradient(circle at 50% 90%, rgba(253, 186, 116, .22), transparent 55%),  /* peach */
    linear-gradient(180deg, #fff7ed 0%, #ffedd5 50%, #fff7ed 100%);
  
  filter: blur(18px);
  transform: scale(1.08);
    }

    .topbar{
      background: rgba(255,255,255,.9);
      border-bottom:1px solid rgba(229,231,235,.9);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      padding:14px 18px;
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
    }
    .title{
      font-weight:1000;
      font-size:20px;
      display:flex;
      align-items:center;
      gap:10px;
      margin:0;
    }

    .glass{
      background: rgba(255,255,255,.9);
      border:1px solid rgba(229,231,235,.9);
      border-radius:18px;
      box-shadow:0 16px 34px rgba(0,0,0,.08);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
    }

    .thumb{
      width:100%;
      height:160px;
      object-fit:cover;
      background:#f3f4f6;
    }
    .cardx{
      overflow:hidden;
      border-radius:18px;
      border:1px solid rgba(229,231,235,.9);
      background:#fff;
      box-shadow:0 12px 22px rgba(0,0,0,.06);
      height:100%;
    }
    .muted{ color:#6b7280; font-weight:700; }
  </style>
</head>

<body>
<div class="blur-bg"></div>

<div class="topbar">
  <div class="title">
    <i class="fa-solid fa-school"></i>
    Educational Places
  </div>

  <div class="d-flex gap-2">
    <a class="btn btn-dark btn-sm fw-bold" href="<%= ctx %>/HomeServlet">
      <i class="fa-solid fa-house me-2"></i>Home
    </a>
  </div>
</div>

<div class="container my-4">

  <div class="glass p-3 mb-3">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
      <div class="fw-bold">
        <i class="fa-solid fa-circle-info me-2"></i>
        Browse all educational places added by the admin
      </div>

      <div class="input-group" style="max-width:420px;">
        <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass"></i></span>
        <input id="q" class="form-control fw-bold" placeholder="Search by name, location, type, level...">
      </div>
    </div>
  </div>

  <div class="row g-3" id="grid">

    <% if(eduList.isEmpty()) { %>
      <div class="col-12">
        <div class="glass p-5 text-center muted">
          <div style="font-size:34px;"><i class="fa-regular fa-face-frown"></i></div>
          No educational places yet.
        </div>
      </div>
    <% } %>

    <% for(Student s : eduList) {
         String img = s.getImageUrl();
         boolean hasImg = (img != null && !img.trim().isEmpty());
    %>

      <div class="col-12 col-md-6 col-lg-4 edu-item">
        <div class="cardx">
          <% if(hasImg) { %>
            <img class="thumb" src="<%= img %>" alt="place">
          <% } else { %>
            <div class="thumb d-flex align-items-center justify-content-center muted">
              NO IMAGE
            </div>
          <% } %>

          <div class="p-3">
            <div style="font-weight:1000; font-size:18px;"><%= s.getFullName() %></div>

            <div class="muted mt-2">
              <i class="fa-solid fa-location-dot me-2"></i><%= s.getUniversity() %>
            </div>

            <div class="muted mt-1">
              <i class="fa-solid fa-layer-group me-2"></i><%= s.getMajor() %>
            </div>

            <div class="muted mt-1">
              <i class="fa-solid fa-graduation-cap me-2"></i><%= s.getLevel() %>
            </div>

            <div class="muted mt-1">
              <i class="fa-solid fa-envelope me-2"></i><%= s.getEmail() %>
            </div>
          </div>
        </div>
      </div>

    <% } %>

  </div>
</div>

<script>
  const q = document.getElementById("q");
  q.addEventListener("keyup", () => {
    const s = q.value.toLowerCase();
    document.querySelectorAll(".edu-item").forEach(card=>{
      card.style.display = card.innerText.toLowerCase().includes(s) ? "" : "none";
    });
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
