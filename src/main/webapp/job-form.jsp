<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Job" %>

<%
  Job j = (Job) request.getAttribute("job");
  boolean editing = (j != null);

  String type = editing && j.getJobType()!=null ? j.getJobType() : "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= editing ? "Edit Job" : "Add Job" %></title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
/* Light RED blurred background */
body{
  font-family:system-ui,Arial;
  min-height:100vh;
  margin:0;
  background:
    radial-gradient(900px 500px at 20% 10%, rgba(239,68,68,.22), transparent 60%),
    radial-gradient(900px 500px at 85% 25%, rgba(239,68,68,.14), transparent 60%),
    #f7f7fb;
}

/* Glass container */
.wrap{ max-width:1000px; margin:30px auto; padding:0 14px; }

.cardx{
  background: rgba(255,255,255,.72);
  border:1px solid rgba(229,231,235,.9);
  border-radius:18px;
  box-shadow:0 18px 40px rgba(0,0,0,.08);
  overflow:hidden;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
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
  font-size:26px;
  font-weight:900;
  margin:0;
  color:#111827;
}

.form-label{ color:#111827; }
.form-control, .form-select{
  border-radius:14px;
  border:1px solid #e5e7eb;
  padding:12px 14px;
  background: rgba(255,255,255,.85);
}

.form-control:focus, .form-select:focus{
  border-color: rgba(239,68,68,.45);
  box-shadow: 0 0 0 .25rem rgba(239,68,68,.12);
}

.btn-save{
  background:#ef4444; /* red */
  color:#fff;
  font-weight:900;
  border-radius:14px;
  padding:12px 18px;
  border:0;
}
.btn-save:hover{ filter:brightness(.96); }

.btn-back{
  border-radius:14px;
  padding:10px 14px;
}

.small-hint{ color:#6b7280; font-size:13px; }

/* badge preview */
.type-badge{
  font-weight:900;
  border-radius:999px;
  padding:7px 14px;
  font-size:12px;
  display:inline-block;
  border:1px solid rgba(229,231,235,.9);
  background: rgba(255,255,255,.8);
  color:#111827;
}

.badge-blue{ background:#3b82f6; color:#fff; border-color:transparent; }      /* Full-time */
.badge-green{ background:#22c55e; color:#064e3b; border-color:transparent; }  /* Part-time */
.badge-yellow{ background:#facc15; color:#713f12; border-color:transparent; } /* Internship */
.badge-red{ background:#ef4444; color:#fff; border-color:transparent; }       /* Contract/Other */
</style>
</head>

<body>

<div class="wrap">
  <div class="cardx">

    <div class="cardx-header">
      <h2 class="title">
        <i class="fa-solid fa-briefcase me-2"></i>
        <%= editing ? "Edit Job Post" : "Add Job Post" %>
      </h2>

      <a href="JobServlet" class="btn btn-dark btn-back">
        <i class="fa-solid fa-arrow-left me-2"></i>Back
      </a>
    </div>

    <div class="p-4">
      <form action="JobServlet" method="post">
        <input type="hidden" name="id" value="<%= editing ? j.getId() : "" %>">

        <div class="row g-4">

          <div class="col-12 col-md-6">
            <label class="form-label fw-bold">Job Title</label>
            <input type="text" name="title" class="form-control" required
                   value="<%= editing ? j.getTitle() : "" %>">
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label fw-bold">Company</label>
            <input type="text" name="company" class="form-control" required
                   value="<%= editing ? j.getCompany() : "" %>">
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label fw-bold">Location</label>
            <input type="text" name="location" class="form-control" required
                   value="<%= editing ? j.getLocation() : "" %>">
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label fw-bold">Job Type</label>
            <select name="jobType" id="jobType" class="form-select" required>
              <option value="" disabled <%= type.isEmpty() ? "selected" : "" %>>Select type</option>
              <option value="Full-time"  <%= "Full-time".equalsIgnoreCase(type) ? "selected" : "" %>>Full-time</option>
              <option value="Part-time"  <%= "Part-time".equalsIgnoreCase(type) ? "selected" : "" %>>Part-time</option>
              <option value="Internship" <%= "Internship".equalsIgnoreCase(type) ? "selected" : "" %>>Internship</option>
              <option value="Contract"   <%= "Contract".equalsIgnoreCase(type) ? "selected" : "" %>>Contract</option>
            </select>

            <div class="mt-2 d-flex align-items-center gap-2">
              <span class="small-hint">Preview:</span>
              <span id="typeBadge" class="type-badge">Select type</span>
            </div>
          </div>

          <div class="col-12">
            <label class="form-label fw-bold">Description</label>
            <textarea name="description" class="form-control" rows="6"
                      placeholder="Write job details..."><%= editing ? j.getDescription() : "" %></textarea>
          </div>

          <div class="col-12">
            <label class="form-label fw-bold">Apply Link</label>
            <input type="url" name="applyLink" class="form-control"
                   placeholder="https://..."
                   value="<%= editing ? j.getApplyLink() : "" %>">
            <div class="small-hint mt-1">Optional: link to the application page.</div>
          </div>

        </div>

        <div class="d-flex gap-2 mt-4">
          <button type="submit" class="btn-save">
            <i class="fa-solid fa-floppy-disk me-2"></i>
            <%= editing ? "Update" : "Save" %>
          </button>

          <a href="JobServlet" class="btn btn-secondary" style="border-radius:14px; padding:12px 18px;">
            Cancel
          </a>
        </div>

      </form>
    </div>

  </div>
</div>

<script>
  function badgeFor(type){
    const badge = document.getElementById("typeBadge");
    badge.className = "type-badge"; // reset

    if(!type){
      badge.textContent = "Select type";
      return;
    }

    const t = type.toLowerCase();
    if(t === "full-time"){
      badge.classList.add("badge-blue");
      badge.textContent = "Full-time";
    }else if(t === "part-time"){
      badge.classList.add("badge-green");
      badge.textContent = "Part-time";
    }else if(t === "internship"){
      badge.classList.add("badge-yellow");
      badge.textContent = "Internship";
    }else if(t === "contract"){
      badge.classList.add("badge-red");
      badge.textContent = "Contract";
    }else{
      badge.classList.add("badge-red");
      badge.textContent = type;
    }
  }

  const select = document.getElementById("jobType");
  badgeFor(select.value);
  select.addEventListener("change", () => badgeFor(select.value));
</script>

</body>
</html>
