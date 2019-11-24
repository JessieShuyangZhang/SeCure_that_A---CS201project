import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;


@WebServlet(name="LoginServlet", urlPatterns={"/LoginServlet"})
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Database database = new Database();
		String errmsg1 = "";
		String errmsg2 = "";
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		PrintWriter out = response.getWriter();
		if (!database.userExist(username)) {
			errmsg1 = "This user does not exist. ";
		}
		else if (!database.authenticate(username, password)) {
			errmsg2 = "Incorrect password. ";
		}
		String errmsg = errmsg1 + errmsg2;
		out.println(errmsg);
		
	}
	
}
