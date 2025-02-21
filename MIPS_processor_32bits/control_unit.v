module control_unit (

output regDst,
output branch,
output memRead,
output memWrite,
output [2:0] ALUop,
output ALUsrc,
output regWrite,
output jump,
output byteOperations,
output move,
input [5:0] opcode);


wire Rtype, addi, subi, andi, ori, lw, sw, lb, sb, slti, beq, bne, j, jal, moveSgn;

not not1 (opcode0_not, opcode[0]);
not not2 (opcode1_not, opcode[1]);
not not3 (opcode2_not, opcode[2]);
not not4 (opcode3_not, opcode[3]);
not not5 (opcode4_not, opcode[4]);
not not6 (opcode5_not, opcode[5]);

// 000000
and and1(Rtype, opcode0_not, opcode1_not, opcode2_not, opcode3_not, opcode4_not, opcode5_not);
// 000010
and and2(addi, opcode0_not, opcode[1], opcode2_not, opcode3_not, opcode4_not, opcode5_not);
// 000011
and and3(subi, opcode[0], opcode[1], opcode2_not, opcode3_not, opcode4_not, opcode5_not);
// 000100
and and4(andi, opcode0_not, opcode1_not, opcode[2], opcode3_not, opcode4_not, opcode5_not);
// 000101
and and5(ori, opcode[0],  opcode1_not, opcode[2], opcode3_not, opcode4_not, opcode5_not);
// 001000
and and6(lw, opcode0_not, opcode1_not, opcode2_not, opcode[3], opcode4_not, opcode5_not);
// 010000
and and7(sw, opcode0_not, opcode1_not, opcode2_not, opcode3_not, opcode[4], opcode5_not);
// 001001
and and8(lb, opcode[0], opcode1_not, opcode2_not, opcode[3], opcode4_not, opcode5_not);
// 010001
and and9(sb, opcode[0], opcode1_not, opcode2_not, opcode3_not, opcode[4], opcode5_not);
// 000111
and and10(slti, opcode[0], opcode[1], opcode[2], opcode3_not, opcode4_not, opcode5_not);
// 100011
and and11(beq, opcode[0], opcode[1], opcode2_not, opcode3_not, opcode4_not, opcode[5]);
// 100111
and and12(bne, opcode[0], opcode[1], opcode[2], opcode3_not, opcode4_not, opcode[5]);
// 111000
and and13(j, opcode0_not, opcode1_not, opcode2_not, opcode[3], opcode[4], opcode[5]);
// 111001
and and14(jal, opcode[0], opcode1_not, opcode2_not, opcode[3], opcode[4], opcode[5]);
// 100000
and and15(moveSgn, opcode0_not, opcode1_not, opcode2_not, opcode3_not, opcode4_not, opcode[5]);

/*

000 -> andi
001 -> ori
100 -> slti
101 -> addi, lb, sb, lw, sw
110 -> subi, beq, bne
111 -> Rtype inst.

*/


or or1(regDst, Rtype);
or or2(branch, beq, bne);
or or3(memRead, lw, lb);
or or4(memWrite, sw, sb);
or or5(ALUop[0], ori, addi, lb, sb, lw, sw, Rtype);
or or6(ALUop[1], subi, beq, bne, Rtype);
or or7(ALUop[2], slti, Rtype, addi, lb, sb, lw, sw, subi, beq, bne);
or or8(ALUsrc, addi, subi, andi, ori, slti, lw, sw, lb, sb);
or or9(regWrite, Rtype, addi, subi, andi, ori, slti, lw, lb, jal, move);
or or10(jump, jal, j);
or or11(byteOperations, lb, sb);
or or12(move, moveSgn);


/*

MOVE INSTRUCTION DEFINITION:

move $rt, $rs => $rt = $rs => Machine code: 100000 Rs Rt 0000 0000 0000 0000
*/



endmodule
