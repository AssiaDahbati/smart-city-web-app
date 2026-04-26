package models;

public class Job {
    private int id;
    private String title;
    private String company;
    private String location;
    private String jobType;
    private String description;
    private String applyLink;

    
    public Job(int id, String title, String company, String location,
               String jobType, String description, String applyLink) {
        this.id = id;
        this.title = title;
        this.company = company;
        this.location = location;
        this.jobType = jobType;
        this.description = description;
        this.applyLink = applyLink;
    }

  
    public Job(String title, String company, String location,
               String jobType, String description, String applyLink) {
        this.title = title;
        this.company = company;
        this.location = location;
        this.jobType = jobType;
        this.description = description;
        this.applyLink = applyLink;
    }

    // GETTERS & SETTERS

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getApplyLink() {
        return applyLink;
    }

    public void setApplyLink(String applyLink) {
        this.applyLink = applyLink;
    }
}
