package models;

public class Student {
    private int id;
    private String fullName;     
    private String university;   
    private String major;       
    private String level;        
    private String email;        
    private String imageUrl;    

    public Student() {}

 
    public Student(String fullName, String university, String major, String level, String email, String imageUrl) {
        this.fullName = fullName;
        this.university = university;
        this.major = major;
        this.level = level;
        this.email = email;
        this.imageUrl = imageUrl;
    }

   
    public Student(int id, String fullName, String university, String major, String level, String email, String imageUrl) {
        this.id = id;
        this.fullName = fullName;
        this.university = university;
        this.major = major;
        this.level = level;
        this.email = email;
        this.imageUrl = imageUrl;
    }
    

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getUniversity() { return university; }
    public void setUniversity(String university) { this.university = university; }

    public String getMajor() { return major; }
    public void setMajor(String major) { this.major = major; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}
