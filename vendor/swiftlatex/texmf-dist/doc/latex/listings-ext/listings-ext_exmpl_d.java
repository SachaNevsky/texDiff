package application.helloworld;
// be: packages
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
// ee: packages
// be: introductory comment
/**
 * HelloWorld.java
 *
 *
 * <br>
 * Created: : 2007/04/12 11:24:48$
 *
 * @author <a href="mailto:N.N_(at)_fh-aachen.de">N.N.</a>
 * @version : 0.0$
 */
// ee: introductory comment
// be: class declaration
public class HelloWorld
// ee: class declaration
{
    // be: specific constructor
    public HelloWorld()
    {
        System.out.println("Object HelloWorld created");
    } // end of specific constructor "HelloWorld()"
    // ee: specific constructor

    public static final void main(final String[] args)
    {
        String baseName = "HelloWorld";
        // ee: using the resource bundle
        ResourceBundle rb = ResourceBundle.getBundle(baseName);
        String greetings = rb.getString("hello_msg");
        // ee: using the resource bundle
        System.out.printf("%s\n", greetings);
    } // end of method "main(String[] args)"
} // end of class "HelloWorld"
