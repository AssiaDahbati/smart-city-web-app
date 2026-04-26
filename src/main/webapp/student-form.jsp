<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Student" %>

<%
  Student s = (Student) request.getAttribute("student");
  boolean editing = (s != null);

  // I keep the SAME backend fields, only rename labels in UI:
  // fullName -> Place Name
  // university -> Location
  // major -> Type/Category
  // level -> Level
  // email -> Contact Email

  String placeName = editing ? s.getFullName() : "";
  String location  = editing ? s.getUniversity() : "";
  String type      = editing ? s.getMajor() : "";
  String level     = editing ? s.getLevel() : "";
  String contact   = editing ? s.getEmail() : "";

  boolean isOtherLevel = (level != null && !level.isEmpty() &&
          !(level.equalsIgnoreCase("1st Year") ||
            level.equalsIgnoreCase("2nd Year") ||
            level.equalsIgnoreCase("3rd Year") ||
            level.equalsIgnoreCase("Master")   ||
            level.equalsIgnoreCase("PhD")));
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title><%= editing ? "Edit Educational Place" : "Add Educational Place" %></title>

 
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
    .wrap{ max-width:900px; margin:30px auto; padding:0 16px; }

    .cardx{
      background: rgba(255,255,255,.75);
      border:1px solid rgba(229,231,235,.9);
      border-radius:18px;
      box-shadow:0 18px 40px rgba(0,0,0,.08);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      overflow:hidden;
    }
    .cardx-header{
      padding:18px 20px;
      border-bottom:1px solid rgba(229,231,235,.9);
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
    }
    .title{
      margin:0;
      font-weight:900;
      color:#111827;
      font-size:22px;
      display:flex;
      align-items:center;
      gap:10px;
    }
    .badge-blue{
      font-size:12px;
      font-weight:900;
      padding:6px 10px;
      border-radius:999px;
      background:#3b82f6;
      color:#fff; 
      letter-spacing:.4px;
    }
    .btn-soft{
      border:0;
      border-radius:12px;
      padding:10px 14px;
      font-weight:900;
    }
    .btn-save{ background:#3b82f6; color:#fff; }
    .btn-save:hover{ filter:brightness(.95); color:#fff; }

    .form-control, .form-select{
      border-radius:12px;
      border:1px solid #e5e7eb;
      padding:10px 12px;
      background: rgba(255,255,255,.9);
    }

    label{ font-weight:800; color:#111827; }
    .hint{ color:#6b7280; font-size:13px; margin-top:6px; }
  </style>
</head>

<body>

<div class="wrap">
  <div class="cardx">

    <div class="cardx-header">
      <div class="d-flex align-items-center gap-2">
        <h2 class="title">
          <i class="fa-solid fa-school"></i>
          <%= editing ? "Edit Educational Place" : "Add Educational Place" %>
        </h2>
        <span class="badge-blue">EDUCATION</span>
      </div>

      <a href="StudentServlet" class="btn btn-soft" style="background:#111827;color:#fff;">
        <i class="fa-solid fa-arrow-left me-2"></i>Back
      </a>
    </div>

    <div class="p-4">
      <form action="StudentServlet" method="post">
        <input type="hidden" name="id" value="<%= editing ? s.getId() : "" %>">

        <div class="row g-3">

 ''
          <div class="col-12 col-md-6">
            <label class="form-label">Place Name</label>
            <input class="form-control" type="text" name=placeName" required value="<%= placeName %>"
                   placeholder="Ex: Abdelmalek Essaadi University / Public Library ...">
          </div>


          <div class="col-12 col-md-6">
            <label class="form-label">Location</label>
            <input class="form-control" type="text" name="location" required value="<%= location %>"
                   placeholder="Ex: Tangier - City Center / Malabata ...">
            <div class="hint">This replaces “Owner / Institution” — now it’s the place address/location.</div>
          </div>

          
          <div class="col-12 col-md-6">
            <label class="form-label">Type / Category</label>
            <input class="form-control" type="text" name="major" required value="<%= type %>"
                   placeholder="Ex: University / Library / Coaching Center / School ...">
          </div>

          
          <div class="col-12 col-md-6">
            <label class="form-label">Level</label>

         
            <select class="form-select" id="levelSelect" required>
              <option value="" <%= (level == null || level.trim().isEmpty()) ? "selected" : "" %>>Select level</option>
              <option value="Primary"     <%= "Primary".equalsIgnoreCase(level) ? "selected" : "" %>>Primary</option>
              <option value="Middle"      <%= "Middle".equalsIgnoreCase(level) ? "selected" : "" %>>Middle</option>
              <option value="High School" <%= "High School".equalsIgnoreCase(level) ? "selected" : "" %>>High School</option>
              <option value="University"  <%= "University".equalsIgnoreCase(level) ? "selected" : "" %>>University</option>
              <option value="Training"    <%= "Training".equalsIgnoreCase(level) ? "selected" : "" %>>Training</option>
              <option value="Other"       <%= isOtherLevel ? "selected" : "" %>>Other</option>
            </select>
 
            <input type="hidden" name="level" id="finalLevel" value="<%= (level == null ? "" : level) %>">

        
            <input type="text"
                   id="otherLevel"
                   class="form-control mt-2"
                   placeholder="Write level (ex: Research Center / Diploma / etc.)"
                   style="display:<%= isOtherLevel ? "block" : "none" %>;"
                   value="<%= isOtherLevel ? level : "" %>">

            <div class="hint">If you choose <b>Other</b>, type the level.</div>
          </div>

   
   
          <div class="col-12">
            <label class="form-label">Contact Email</label>
            <input class="form-control" type="email" name="email" required value="<%= contact %>"
                   placeholder="Ex: info@place.com">
          </div>

          <div class="col-12 d-flex gap-2 mt-2">
            <button type="submit" class="btn btn-soft btn-save">
              <i class="fa-solid fa-floppy-disk me-2"></i>
              <%= editing ? "Update" : "Save" %>
            </button>

            <a class="btn btn-soft" style="background:#e5e7eb;color:#111827;" href="StudentServlet">
              Cancel
            </a>
          </div>

        </div>
      </form>
    </div>

  </div>
</div>

<script>
  const levelSelect = document.getElementById("levelSelect");
  const otherLevel  = document.getElementById("otherLevel");
  const finalLevel  = document.getElementById("finalLevel");

  function updateLevel(){
    if(levelSelect.value === "Other"){
      otherLevel.style.display = "block";
      otherLevel.required = true;
      finalLevel.value = otherLevel.value;
    } else {
      otherLevel.style.display = "none";
      otherLevel.required = false;
      finalLevel.value = levelSelect.value;
    }
  }

  levelSelect.addEventListener("change", updateLevel);
  otherLevel.addEventListener("input", () => finalLevel.value = otherLevel.value);

  updateLevel();
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
