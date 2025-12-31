class Badge {
    public String print(Integer id, String name, String department) {
        String idString = (id == null) ? "" : "[" + id + "] - ";
        String deptString = (department == null) ? "OWNER" : department.toUpperCase();
        return idString + name + " - " + deptString;
    }
}
