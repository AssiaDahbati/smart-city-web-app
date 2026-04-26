package models;

public class Business {
    private int id;
    private String name;
    private String category;
    private String location;
    private String description;
    private String contactEmail;

    // For reading from DB
    public Business(int id, String name, String category, String location,
                    String description, String contactEmail) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.location = location;
        this.description = description;
        this.contactEmail = contactEmail;
    }

    // For inserting
    public Business(String name, String category, String location,
                    String description, String contactEmail) {
        this.name = name;
        this.category = category;
        this.location = location;
        this.description = description;
        this.contactEmail = contactEmail;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public String getCategory() { return category; }
    public String getLocation() { return location; }
    public String getDescription() { return description; }
    public String getContactEmail() { return contactEmail; }

    public void setName(String name) { this.name = name; }
    public void setCategory(String category) { this.category = category; }
    public void setLocation(String location) { this.location = location; }
    public void setDescription(String description) { this.description = description; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }
}
