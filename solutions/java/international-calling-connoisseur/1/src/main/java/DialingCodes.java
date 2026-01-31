import java.util.HashMap;
import java.util.Map;

public class DialingCodes {
    private Map<Integer, String> dialingCodes = new HashMap<>();

    public Map<Integer, String> getCodes() {
        return this.dialingCodes;
    }

    public void setDialingCode(Integer code, String country) {
        dialingCodes.put(code, country);
    }

    public String getCountry(Integer code) {
        return dialingCodes.get(code);
    }

    public void addNewDialingCode(Integer code, String country) {
        if (!dialingCodes.containsKey(code) &&
                !dialingCodes.containsValue(country)) {
            dialingCodes.put(code, country);
        }
    }

    public Integer findDialingCode(String country) {
        for (Map.Entry<Integer, String> en : dialingCodes.entrySet()) {
            if (en.getValue() == country) {
                return en.getKey();
            }
        }
        return null;
    }

    public void updateCountryDialingCode(Integer code, String country) {
        if (dialingCodes.containsValue(country)) {
            dialingCodes.remove(findDialingCode(country));
            dialingCodes.put(code, country);
        }
    }
}
