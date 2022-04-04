package Mips;
import java.util.Hashtable;
import Symbol.Symbol;
import Temp.Temp;
import Temp.Label;
import Frame.Frame;
import Frame.Access;
import Frame.AccessList;

public class MipsFrame extends Frame {

  private int count = 0;
  private int offset = 0;
  public Frame newFrame(Symbol name, Util.BoolList formals) {
    Label label;
    if (name == null)
      label = new Label();
    else if (this.name != null)
      label = new Label(this.name + "." + name + "." + count++);
    else
      label = new Label(name);
    return new MipsFrame(label, formals);
  }

  public MipsFrame() {}
  private MipsFrame(Label n, Util.BoolList f) {
    name = n;
    this.formals = allocFormals(0,f);
  }

  private static final int wordSize = 4;
  public int wordSize() { return wordSize; }

  @Override
  public Access allocLocal(boolean escape) { 
      if(escape) {
          count -= wordSize;
          return new InFrame(count);
      } else {
          return new InReg(new Temp());
      }
  }
  
  private AccessList allocFormals(int offset, Util.BoolList args) {
      if (args == null)
          return null;
      else {
          Access access;
          if(args.head) {
              access = new InFrame(offset);
              offset += wordSize;
          } else access = new InReg(new Temp());
          return new AccessList(access, allocFormals(offset, args.tail));
      }
  }
}