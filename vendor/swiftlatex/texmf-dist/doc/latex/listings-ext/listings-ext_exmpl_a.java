package application.helloworld;
// be: packages
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
// ee: packages
/**
 * HelloWorld.java
 */
public class HelloWorld
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
        // be: using the resource bundle
        ResourceBundle rb = ResourceBundle.getBundle(baseName);
        String greetings = rb.getString("hello_msg");
        // ee: using the resource bundle
        System.out.printf("%s\n", greetings);
    } // end of method "main(String[] args)"
} // end of class "HelloWorld"
