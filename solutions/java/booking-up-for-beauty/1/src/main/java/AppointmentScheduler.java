import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.apache.commons.text.WordUtils;


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
        int year = appointmentDate.getYear();
        String month = WordUtils.capitalizeFully(appointmentDate.getMonth().toString());
        String weekDay = WordUtils.capitalizeFully(appointmentDate.getDayOfWeek().toString());
        int monthDay = appointmentDate.getDayOfMonth();
        LocalTime localTime = appointmentDate.toLocalTime();
        DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("h:mm a");
        String time = timeFormat.format(localTime);
        return "You have an appointment on " + weekDay + ", " + month + " "
            + monthDay + ", " + year + ", at " + time + ".";
    }

    public LocalDate getAnniversaryDate() {
        int year = now.getYear();
        return LocalDate.of(year, 9, 15);
    }
}
