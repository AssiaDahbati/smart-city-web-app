<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Student" %>

<%
  Student s = (Student) request.getAttribute("student");
  boolean editing = (s != null);

  String fullName   = editing ? s.getFullName() : "";
  String university = editing ? s.getUniversity() : "";
  String major      = editing ? s.getMajor() : "";
  String level      = editing ? s.getLevel() : "";
  String email      = editing ? s.getEmail() : "";
  String imageUrl   = editing ? s.getImageUrl() : "";
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title><%= editing ? "Edit Place" : "Add Place" %></title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

    .wrap{ max-width:900px; margin:30px auto; padding:0 16px; }
    .cardx{
      background: rgba(255,255,255,.9);
      border:1px solid rgba(229,231,235,.9);
      border-radius:18px;
      box-shadow:0 18px 40px rgba(0,0,0,.08);
      overflow:hidden;
    }
    .cardx-header{
      padding:18px 20px;
      border-bottom:1px solid rgba(229,231,235,.9);
      display:flex;
      align-items:center;
      justify-content:space-between;
    }
    .title{ margin:0; font-weight:950; font-size:22px; }
    .thumb{
      width:100%;
      max-height:220px;
      border-radius:16px;
      object-fit:cover;
      border:1px solid #e5e7eb;
      background:#f3f4f6;
    }
    label{ font-weight:800; }
  </style>
</head>

<body>
<div class="wrap">
  <div class="cardx">

    <div class="cardx-header">
      <h2 class="title"><i class="fa-solid fa-school me-2"></i><%= editing ? "Edit Educational Place" : "Add Educational Place" %></h2>
      <a href="<%= request.getContextPath() %>/StudentServlet" class="btn btn-dark btn-sm">
        <i class="fa-solid fa-arrow-left me-2"></i>Back
      </a>
    </div>

    <div class="p-4">
      <form action="<%= request.getContextPath() %>/StudentServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= editing ? s.getId() : "" %>">
        <input type="hidden" name="existingImageUrl" value="<%= imageUrl == null ? "" : imageUrl %>">

        <div class="row g-3">

          <div class="col-12 col-md-6">
            <label class="form-label">Place Name</label>
            <input class="form-control" type="text" name="fullName" required value="<%= fullName %>">
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label">Location</label>
            <input class="form-control" type="text" name="university" required value="<%= university %>">
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label">Type / Category</label>
            <input class="form-control" type="text" name="major" required value="<%= major %>">
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label">Level</label>
            <input class="form-control" type="text" name="level" required value="<%= level %>">
          </div>

          <div class="col-12">
            <label class="form-label">Contact Email</label>
            <input class="form-control" type="email" name="email" required value="<%= email %>">
          </div>

          <!-- IMAGE UPLOAD -->
          <div class="col-12">
            <label class="form-label">Place Image (optional)</label>
            <input class="form-control" type="file" name="imageFile" accept=".png,.jpg,.jpeg,.webp" onchange="previewImg(event)">
            <div class="form-text fw-bold text-muted">
              Allowed: png / jpg / jpeg / webp (max 5MB). If you don’t upload a new one, the old image stays.
            </div>
          </div>

          <!-- PREVIEW -->
          <div class="col-12">
            <% if (imageUrl != null && !imageUrl.trim().isEmpty()) { %>
              <img id="imgPreview" class="thumb mt-2" src="<%= imageUrl %>" alt="Place image">
            <% } else { %>
              <img id="imgPreview" class="thumb mt-2" style="display:none;" alt="preview">
            <% } %>
          </div>

          <div class="col-12 d-flex gap-2 mt-2">
            <button type="submit" class="btn btn-primary fw-bold">
              <i class="fa-solid fa-floppy-disk me-2"></i><%= editing ? "Update" : "Save" %>
            </button>
            <a class="btn btn-secondary fw-bold" href="<%= request.getContextPath() %>/StudentServlet">Cancel</a>
          </div>

        </div>
      </form>
    </div>

  </div>
</div>

<script>
  function previewImg(e){
    const file = e.target.files && e.target.files[0];
    if(!file) return;
    const img = document.getElementById("imgPreview");
    img.src = URL.createObjectURL(file);
    img.style.display = "block";
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
