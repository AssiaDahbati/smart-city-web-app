<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Tourism" %>

<%
  String ctx = request.getContextPath();

  Tourism t = (Tourism) request.getAttribute("tourism");
  boolean editing = (t != null);

  String currentImg = (editing && t.getImageUrl() != null) ? t.getImageUrl() : "";

  String latVal = "";
  String lngVal = "";
  if(editing){
    try{
      if(t.getLatitude() != null) latVal = String.valueOf(t.getLatitude());
      if(t.getLongitude() != null) lngVal = String.valueOf(t.getLongitude());
    }catch(Exception ex){}
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= editing ? "Edit Tourism" : "Add Tourism" %></title>

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


    .wrap{ max-width:920px; margin:30px auto; padding:0 16px; }

    .cardx{
      background: rgba(255,255,255,.90);
      border:1px solid rgba(229,231,235,.9);
      border-radius:18px;
      box-shadow:0 16px 34px rgba(0,0,0,.08);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      overflow:hidden;
    }

    .cardx-header{
      padding:18px 20px;
      border-bottom:1px solid rgba(229,231,235,.9);
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:12px;
    }

    .title{
      font-size:22px;
      font-weight:900;
      margin:0;
      display:flex;
      align-items:center;
      gap:10px;
    }

    .form-control{
      border-radius:12px;
      border:1px solid #e5e7eb;
      padding:10px 12px;
      font-weight:700;
      background: rgba(255,255,255,.92);
    }

    label{ font-weight:900; }

    .btn-save{
      background:#f59e0b;
      color:#111827;
      font-weight:900;
      border-radius:12px;
      padding:10px 16px;
      border:0;
    }

    .preview{
      width:260px;
      height:170px;
      object-fit:cover;
      border-radius:14px;
      border:1px solid #e5e7eb;
      background:#f3f4f6;
    }

    .hint{ color:#6b7280; font-weight:700; font-size:13px; }
  </style>
</head>

<body>
<div class="blur-bg"></div>

<div class="wrap">
  <div class="cardx">
    <div class="cardx-header">
      <h2 class="title">
        <i class="fa-solid fa-umbrella-beach"></i>
        <%= editing ? "Edit Tourism Place" : "Add Tourism Place" %>
      </h2>

      <a href="<%= ctx %>/TourismServlet" class="btn btn-dark fw-bold" style="border-radius:12px;">
        <i class="fa-solid fa-arrow-left me-2"></i>Back
      </a>
    </div>

    <div class="p-4">
      <!-- enctype for file upload -->
      <form action="<%= ctx %>/TourismServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= editing ? t.getId() : "" %>">

        <div class="mb-3">
          <label class="form-label">Place Name</label>
          <input type="text" name="name" class="form-control"
                 required value="<%= editing ? t.getName() : "" %>">
        </div>

        <div class="mb-3">
          <label class="form-label">Location</label>
          <input type="text" name="location" class="form-control"
                 required value="<%= editing ? t.getLocation() : "" %>">
        </div>

        <div class="mb-3">
          <label class="form-label">Description</label>
          <textarea name="description" class="form-control" rows="4"><%= editing ? (t.getDescription()==null?"":t.getDescription()) : "" %></textarea>
        </div>

       
        <div class="row g-3 mb-2">
          <div class="col-12 col-md-6">
            <label class="form-label">Latitude</label>
            <input type="number" step="0.0000001" name="latitude" class="form-control"
                   placeholder="Example: 35.7806" value="<%= latVal %>">
            <div class="hint">Optional, but required if you want it to appear on the map.</div>
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Longitude</label>
            <input type="number" step="0.0000001" name="longitude" class="form-control"
                   placeholder="Example: -5.8137" value="<%= lngVal %>">
          </div>
        </div>

        <!-- Upload -->
        <div class="mb-3 mt-2">
          <label class="form-label">Upload Image</label>
          <input type="file" name="imageFile" class="form-control" accept="image/*">
          <div class="hint">If you don’t upload a new image, the old one stays.</div>
        </div>

        <% if (editing) { %>
          <input type="hidden" name="oldImageUrl" value="<%= currentImg %>">

          <div class="mb-3">
            <label class="form-label">Current Image</label><br>
            <% if (currentImg != null && !currentImg.trim().isEmpty()) { %>
              <img class="preview mt-2" src="<%= currentImg %>" alt="current image">
            <% } else { %>
              <div class="hint mt-2">No image yet.</div>
            <% } %>
          </div>
        <% } %>

        <div class="d-flex gap-2">
          <button type="submit" class="btn-save">
            <i class="fa-solid fa-floppy-disk me-2"></i>
            <%= editing ? "Update" : "Save" %>
          </button>

          <a href="<%= ctx %>/TourismServlet" class="btn btn-secondary fw-bold" style="border-radius:12px;">
            Cancel
          </a>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
