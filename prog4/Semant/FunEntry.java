package Semant;

public class FunEntry extends Entry {
  Translate.Level level;
  public Types.RECORD formals;
  public Types.Type result;
  public boolean hasBody;
  FunEntry(Types.RECORD f, Types.Type r) {
    this(null, f, r, true);
  }
  FunEntry(Types.RECORD f, Types.Type r, boolean b) {
    this(null, f, r, b);
  }
  FunEntry(Translate.Level v, Types.RECORD f, Types.Type r, boolean b) {
    level = v;
    formals = f;
    result = r;
    hasBody = b;
  }
}
