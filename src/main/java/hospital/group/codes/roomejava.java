package hospital.group.codes;

public class roomejava {
    private String roomId;
    private String roomNumber;
    private String roomType;
    private String availabilityStatus;
    private String assignedPatientId;
    private int floorNumber;
    private String departmentId;
    private String lastCleanedAt;
    private double dailyRate;

    // Constructor with parameters
    public roomejava(String roomId, String roomNumber, String roomType, String availabilityStatus, 
                     String assignedPatientId, int floorNumber, String departmentId, String lastCleanedAt, 
                     double dailyRate) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.availabilityStatus = availabilityStatus;
        this.assignedPatientId = assignedPatientId;
        this.floorNumber = floorNumber;
        this.departmentId = departmentId;
        this.lastCleanedAt = lastCleanedAt;
        this.dailyRate = dailyRate;
    }

    // Getter and Setter methods (optional for brevity)
    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public String getAssignedPatientId() {
        return assignedPatientId;
    }

    public void setAssignedPatientId(String assignedPatientId) {
        this.assignedPatientId = assignedPatientId;
    }

    public int getFloorNumber() {
        return floorNumber;
    }

    public void setFloorNumber(int floorNumber) {
        this.floorNumber = floorNumber;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getLastCleanedAt() {
        return lastCleanedAt;
    }

    public void setLastCleanedAt(String lastCleanedAt) {
        this.lastCleanedAt = lastCleanedAt;
    }

    public double getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(double dailyRate) {
        this.dailyRate = dailyRate;
    }
}
