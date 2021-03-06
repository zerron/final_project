package sport_system.model;

import java.sql.SQLException;
import java.util.List;

public interface SportDAO {

	int save(SportBean pb);

	SportBean getSport(int pk);

	int deleteSport(SportBean pb);

	int updateSport(SportBean pb);

	List<SportBean> getAllSports() throws SQLException;
	
}