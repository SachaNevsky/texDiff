// teched.java
// (C) Copyright 1998 by Robert S. Sutor. All rights reserved.

// We first import the classes we need from the standard Java
// distribution. This will work with Java 1.0 or higher.

import java.awt.*;
import java.awt.event.*;
import java.lang.*;
import java.applet.Applet;

// The following brings in the Netscape LiveConnect classes
// that we will use.

import netscape.javascript.JSObject;

// These are the classes that we use that are exposed by
// techexplorer. The first is the basic interface to the
// plug-in. The others are the event and listener classes.

import ibm.techexplorer.plugin.techexplorerPlugin;
import ibm.techexplorer.awt.AWTEvent;
import ibm.techexplorer.awt.event.KeyListener;
import ibm.techexplorer.awt.event.KeyEvent;

public class teched
    extends java.applet.Applet
    implements KeyListener
{
    // The JavaScript window object
    JSObject           Window           = null;
    // The JavaScript document object
    JSObject           Document         = null;

    // The techexplorer plug-in instance
    techexplorerPlugin tePlugin         = null;
    // The editable text area for the markup source
    TextArea           markupInputArea  = null;
    // The 'Clear input' button
    Button             clearInputButton = null;

    // A utility buffer for holding the markup.
    StringBuffer       markupString     = new StringBuffer("");

    public boolean action(Event evt, Object arg) {
        // We only handle the 'Clear input' action.

        boolean result = false;

        if ( evt.target == clearInputButton ) {
            // Empty the markup edit area.
            markupInputArea.setText( "" );

            // Reinitialize the techexplorer document. This
            // needs to be a non-empty string to actually
            // updated the document, so we give it some
            // non-visible input.

            tePlugin.reloadFromTeXString( "\\(\\)" );

            result = true;
        }

        return result;
    }

    public void init() {
        // Initialize the components we are displaying
        // with this Java applet.

        clearInputButton  = new Button("Clear input");
        markupInputArea   = new TextArea( 5, 80 );

        this.setLayout( new FlowLayout() );
        this.add( markupInputArea );
        this.add( clearInputButton );
    }

    public void keyPressed( ibm.techexplorer.awt.event.KeyEvent e ) {
        // We don't do anything with this event given us by
        // techexplorer. But see 'keyTyped'.
    }

    public void keyTyped( ibm.techexplorer.awt.event.KeyEvent e ) {
        // This is a naive (but effective!) way of dealing with
        // keys coming to us from techexplorer. We grab the key
        // that was pressed and put it on the end of our markup.
        // Then we update the techexplorer window.

        if ( e.getSource() == tePlugin ) {
            markupInputArea.appendText(
                ( new Character( e.getKeyChar() )).toString() );

            // This replaces the document within the techexplorer
            // window with that gotten by parsing the string
            // passed to it.

            tePlugin.reloadFromTeXString( markupInputArea.getText() );
        }
    }

    public void keyReleased( ibm.techexplorer.awt.event.KeyEvent e ) {
        // This is where we deal with key release events coming to
        // us from the techexplorer window.

        switch ( e.getKeyCode() ) {
          case KeyEvent.VK_DELETE:
            // When we see a 'delete' key, we remove the last character
            // in the markup.

            if ( e.getSource() == tePlugin ) {
                markupString = new StringBuffer( markupInputArea.getText() );
                int length = markupString.length();
                if ( length > 0 )
                    --length;
                markupString.setLength( length );
                markupInputArea.setText( markupString.toString() );
                tePlugin.reloadFromTeXString( markupInputArea.getText() );
            }
            break;

          case KeyEvent.VK_ENTER:
            // When we see that the 'enter' key has been pressed, we
            // insert a newline in the markup. This improves readability.

            if ( e.getSource() == tePlugin ) {
                markupInputArea.appendText( "\n" );
                tePlugin.reloadFromTeXString( markupInputArea.getText() );
            }
            break;

          default:
            break;
        }
    }

    public boolean keyUp( Event evt, int key )
    {
        // This key is one from the markup input area.
        // When a key is released, update the techexplorer
        // document with the current markup.

        boolean result = false;

        if ( evt.target == markupInputArea ) {
            if ( evt.id == Event.KEY_RELEASE ) {
                int length = markupInputArea.getText().length();
                if ( length > 0 )
                    tePlugin.reloadFromTeXString(
                        markupInputArea.getText() );
                else
                    tePlugin.reloadFromTeXString( "\\(\\)" );
            }

            result = true;
        }

        return result;
    }

    public void start() {
        // Initialize the Netscape JavaScript objects.

        Window   = (JSObject) JSObject.getWindow(this);
        Document = (JSObject) Window.getMember("document");

        // Try to get the techexplorer plug-in object.
        tePlugin = (techexplorerPlugin) Document.getMember("teInput");

        if ( tePlugin == null )
            // If we didn't get it, print a debug message.
            System.out.println("teched: start(): null teched");
        else
            // Otherwise add the listener for techexplorer keys.
            tePlugin.addKeyListener( (KeyListener) this );
    }

    public void stop() {
        if ( tePlugin == null )
            // If we don't have the techexplorer plug-in object,
            // print a debug message.
            System.out.println("teched: stop(): null teched");
        else
            // Otherwise remove the listener for techexplorer keys.
            tePlugin.removeKeyListener( (KeyListener) this );
    }
}
