// MySAXApp.java -- Main driver class 
//  --> calls InvitationSAX which has customized code
import org.xml.sax.Parser;
import org.xml.sax.DocumentHandler;
import org.xml.sax.helpers.ParserFactory;

public class MySAXApp {
  static final String parserClass = "com.microstar.xml.SAXDriver";
  public static void main (String args[])
    throws Exception
  { Parser parser = ParserFactory.makeParser(parserClass);
    DocumentHandler handler = new InvitationSAX();
    parser.setDocumentHandler(handler);
    for (int i = 0; i < args.length; i++) {parser.parse(args[i]);}
  }
}
