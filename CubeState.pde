import java.io.FileReader; 
import java.util.Iterator; 
import java.util.Map; 
  
import org.json.simple.JSONArray; 
import org.json.simple.JSONObject; 
import org.json.simple.parser.*;

public class CubeState {

    private Integer[][] cubeStateColors = {{}};

    private Integer getColorByString(String colorName){
        switch (colorName) {
            case "GREEN":
                return GREEN;
            case "RED":
                return RED;
            case "BLUE":
                return BLUE;
            case "ORANGE":
                return ORANGE;
            case "YELLOW":
                return YELLOW;
            case "WHITE":
                return WHITE;
            default:
                debug.msg("Invalid color name string, cannot find color: " + colorName);
                return null;
        }
    }

    public Color[][] loadColorStateFromFile(String filePath){
        // Parse JSON file
        JSONObject stateObj = (JSONObject) new JSONParser().parse(new FileReader(stateFilePath)); // Use parseJSONObject() instead: for processing???
        this.cubeStateColors = {{}};

        String[] faces = {"F", "L", "B", "R", "U", "D"};
        int i = 1; // Indexing starting at 1 to respect defined standard for cube state representation
        for (String currentFaceName : faces){
            Map colors = (Map) stateObj.get(currentFaceName);
            Iterator<Map.Entry> itr = colors.entrySet().iterator(); 
            while (itr.hasNext()) { 
                Map.Entry pair = itr1.next(); 
                println(pair.getKey() + " : " + pair.getValue());
                
                // Get tile index and color, and store it
                int tileIndex = Integer.parseInt(pair.getKet());
                Color tileColor = getColorByString(pair.getValue());
                this.cubeStateColors[i][tileIndex] = tileColor;
            } 
            i++;
        }

        return cubeStateColors;
    }

    public saveColorStateToFile(Color[][] currentState, String fileName){
        this.cubeStateColors = currentState;

    }

}