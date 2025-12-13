import org.xml.sax.HandlerBase;
import org.xml.sax.AttributeList;

public class InvitationSAX extends HandlerBase {

  public void startElement (String Ename, AttributeList atts)
  { if (Ename.equals("invitation"))
      {System.out.print("\\documentclass[]{article}\n"
                      + "\\usepackage{invitation}\n" 
                      + "\\begin{document}\n"
                      + "\\begin{Front}\n");
       for (int i = 0; i < atts.getLength(); i++) {
         String Aname = atts.getName(i);     
         String type = atts.getType(i);
         String value = atts.getValue(i);
         if (Aname.equals("date")) 
           System.out.print("\\Date{" + value + "}\n");
         else if (Aname.equals("signature")) 
           System.out.print("\\Signature{" + value + "}\n");
         else if (Aname.equals("to"))
           System.out.print("\\To{" + value + "}\n");
         else if (Aname.equals("where")) 
           System.out.print("\\Where{" + value + "}\n");
         else if (Aname.equals("why"))
           System.out.print("\\Why{" + value + "}\n");
         else System.out.print("INVALID ATTRIBUTE!!! " + value + "\n");
       } // end attributes of invitation
       System.out.println("\\end{Front}");
       System.out.println("\\begin{Body}");
      } // end element invitation
    if (Ename.equals("par"))
      System.out.print("\\par ");
    if (Ename.equals("emph"))
      System.out.print("\\emph{");
  } // End of startElement

  public void endElement (String Ename)
  { if (Ename.equals("invitation")) 
      System.out.print("\\end{Body}\n"
                     + "\\begin{Back}\n" 
                     + "\\end{Back}\n" 
                     + "\\end{document}\n");
    if (Ename.equals("emph"))
       System.out.print("}");
//  if (Ename.equals("par")) ---> do nothing
  } // End of endElement 

  public void characters(char ch[],int start,int length)
  { for (int i=start; i<start+length; i++)
      {System.out.print(ch[i]);}
  } // End of characters

} // end of InvitationSAX
