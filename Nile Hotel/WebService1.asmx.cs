using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

namespace Nile_Hotel
{
    /// <summary>
    /// Browse Rooms for client&staff, Book, checkOut, Cancel.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        String databaseAddress = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|CentralDB.mdf;Integrated Security=True;User Instance=True";
    

        [WebMethod]
        public DataTable browseRooms(string dateIn, string dateOut, string roomPref)
        {
            
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = databaseAddress;
            string strSelect;

            if (roomPref == "Any")
                strSelect = "Select* FROM Rooms";
            else
                strSelect = "Select* FROM Rooms WHERE roomType = '" + roomPref + "'";

            SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
            DataTable filteredRooms = new DataTable("filteredRooms");
            DataColumn dc = new DataColumn("roomNumber");
            DataColumn dc2 = new DataColumn("roomType");
            filteredRooms.Columns.Add(dc);
            filteredRooms.Columns.Add(dc2);
            try
            {
                conn.Open();
                filteredRooms.Load(cmdSelect.ExecuteReader());

                for (int i = 0; i < filteredRooms.Rows.Count; i++)
                {
                    string strSelectB = "Select* FROM Reservations WHERE roomNumber = '" + filteredRooms.Rows[i]["RoomNumber"].ToString()
                        + "' AND ((checkOut > '" + dateIn
                        + "' AND checkIn <= '" + dateIn
                        + "') OR (checkOut >= '" + dateOut
                        + "' AND checkIn < '" + dateOut
                        + "'))";

                    SqlCommand cmdSelectB = new SqlCommand(strSelectB, conn);

                    try
                    {
                        DataTable reservations = new DataTable();
                        reservations.Load(cmdSelectB.ExecuteReader());

                        if (reservations.Rows.Count != 0)
                        {
                            filteredRooms.Rows[i].Delete();
                        }

                    }
                    catch (SqlException er)
                    {
                        filteredRooms.Clear();
                        return filteredRooms;
                    }
                }
                conn.Close();
                return filteredRooms;
            }
            catch (SqlException er)
            {
                filteredRooms.Clear();
                return filteredRooms;
            }
        }

        [WebMethod]
        public int book(string guest, string roomNumber, string roomType, string season, string checkIn, string checkOut)
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = databaseAddress;
            // Getting RefNo
            string strSelect = "SELECT MAX(refNo) FROM Reservations";

            SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
            SqlDataReader reader;
            try
            {
                conn.Open();
                reader = cmdSelect.ExecuteReader();

                int refNo = 0;

                if (reader.Read())
                    if (reader.GetValue(0) != DBNull.Value)
                        refNo = (int)reader.GetValue(0);
                reader.Close();
                conn.Close();
                Random rnd = new Random();
                int incr = rnd.Next(100, 10000); // creates a number between 1 and 100

                refNo = refNo + incr;

                string strInsert = "Insert INTO Reservations(refNo, guest, roomType, checkIn, checkOut, roomNumber, season, bill) VALUES('"
                + refNo + "', '"
                + guest + "', '"
                + roomType + "', '"
                + checkIn + "', '"
                + checkOut + "', '"
                + roomNumber + "', '"
                + season + "', "
                + 0 + ")";

                SqlCommand cmdInsert = new SqlCommand(strInsert, conn);

                try
                {
                    conn.Open();
                    cmdInsert.ExecuteNonQuery();
                    conn.Close();
                    return refNo;
                }
                catch (SqlException er)
                {
                    return -1;
                }
            }
            catch (SqlException er)
            {
                return -1;
            }
        }
        [WebMethod]
        public bool cancel(string refNo) 
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = databaseAddress;
            string strDelete = "DELETE FROM Reservations WHERE refNo = " + refNo;

            SqlCommand cmdDelete = new SqlCommand(strDelete, conn);

            try
            {
                conn.Open();
                cmdDelete.ExecuteNonQuery();
                conn.Close();
                return true;
            }
            catch(SqlException er)
            {
                return false;
            }
        }

        [WebMethod]
        public bool checkOut(string refNo)
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = databaseAddress;
            string strUpdate = "UPDATE Reservations SET bill = 1 WHERE refNo = '" + refNo + "'";
            SqlCommand cmdUpdate = new SqlCommand(strUpdate, conn);

            try
            {
                conn.Open();
                cmdUpdate.ExecuteNonQuery();
                conn.Close();
                return true;
            }
            catch (SqlException er) 
            {
                return false;
            }
        }
    }
}
