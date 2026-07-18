package dao;

import database.DBConnection;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsersDAO {

    public static void loadUsers(JTable table) {
        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT userId, Username FROM Users";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            DefaultTableModel model = new DefaultTableModel();
            model.addColumn("User ID");
            model.addColumn("Username");

            while (rs.next()) {
                model.addRow(new Object[]{
                        rs.getInt("userId"),
                        rs.getString("Username")
                });
            }

            table.setModel(model);

        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(null,
                    "Error loading users",
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }
}
