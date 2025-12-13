// ee: package declaration
package application.helloworld;
// ee: package declaration
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

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
        ResourceBundle rb = ResourceBundle.getBundle(baseName);
        String greetings = rb.getString("hello_msg");
        System.out.printf("%s\n", greetings);
    } // end of method "main(String[] args)"
} // end of class "HelloWorld"
