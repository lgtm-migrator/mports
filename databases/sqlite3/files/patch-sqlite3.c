--- sqlite3.c.orig	2020-01-27 12:25:19.000000000 -0800
+++ sqlite3.c	2020-04-23 19:24:26.380323000 -0700
@@ -121302,12 +121302,14 @@
             x = *sqlite3VdbeGetOp(v, addrConflictCk);
             if( x.opcode!=OP_IdxRowid ){
               int p2;      /* New P2 value for copied conflict check opcode */
+              const char *zP4;
               if( sqlite3OpcodeProperty[x.opcode]&OPFLG_JUMP ){
                 p2 = lblRecheckOk;
               }else{
                 p2 = x.p2;
               }
-              sqlite3VdbeAddOp4(v, x.opcode, x.p1, p2, x.p3, x.p4.z, x.p4type);
+              zP4 = x.p4type==P4_INT32 ? SQLITE_INT_TO_PTR(x.p4.i) : x.p4.z;
+              sqlite3VdbeAddOp4(v, x.opcode, x.p1, p2, x.p3, zP4, x.p4type);
               sqlite3VdbeChangeP5(v, x.p5);
               VdbeCoverageIf(v, p2!=x.p2);
             }
