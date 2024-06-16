import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/batterie";
        String user = "root";
        String password = "Pordenone";

        try {
            Connection mydb = DriverManager.getConnection(url, user, password);

            int anno = 2022;
            String sql = "CALL numeroAutoProdottePerAnno("+anno+")";
            PreparedStatement mycursor = mydb.prepareStatement(sql);

            ResultSet myresult = mycursor.executeQuery();

            while (myresult.next()) {
                String nomeCasa = myresult.getString("CasaAutomobilistica");
                int numeroAuto = myresult.getInt("NumeroAutoProdotte");

                System.out.println("nome: " + nomeCasa + ", numero auto prodotte: " + numeroAuto);
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
        }
    }
}