import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


class AppointmentScheduler {
    private final LocalDateTime now = LocalDateTime.now();

    public LocalDateTime schedule(String appointmentDateDescription) {
        DateTimeFormatter parser = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(appointmentDateDescription, parser);
        return dateTime;
    }

    public boolean hasPassed(LocalDateTime appointmentDate) {
        return appointmentDate.isBefore(now);
    }

    public boolean isAfternoonAppointment(LocalDateTime appointmentDate) {
        int hour = appointmentDate.getHour();
        return (hour >= 12 && hour < 18) ? true : false;
    }

    public String getDescription(LocalDateTime appointmentDate) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
        "'You have an appointment on' EEEE, MMMM d, yyyy, 'at' h:mm a'.'");
        return appointmentDate.format(formatter);
    }

    public LocalDate getAnniversaryDate() {
        int year = now.getYear();
        return LocalDate.of(year, 9, 15);
    }
}
