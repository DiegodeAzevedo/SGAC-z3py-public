module filepath/param/graph/property/req
open filepath/alloy3/sgac_core
//**********************
//***Graph signatures***
//**********************
one sig s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13 extends Subject{}{}
fact{
subSucc=s1->s0+
         s2->s0+
         s3->s0+
         s4->s1+
         s4->s3+
         s5->s0+
         s5->s2+
         s5->s3+
         s5->s4+
         s6->s0+
         s6->s3+
         s6->s4+
         s6->s5+
         s7->s0+
         s7->s1+
         s7->s2+
         s7->s3+
         s7->s4+
         s8->s3+
         s8->s4+
         s9->s0+
         s9->s6+
         s10->s0+
         s10->s1+
         s10->s4+
         s11->s0+
         s11->s1+
         s11->s4+
         s11->s7+
         s12->s0+
         s12->s1+
         s12->s2+
         s12->s3+
         s12->s9+
         s12->s10+
         s13->s2+
         s13->s3+
         s13->s4+
         s13->s5+
         s13->s7+
         s13->s8+
         s13->s9+
         s13->s12}
one sig r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13 extends Resource{}{}
fact{
resSucc=r1->r0+
         r2->r0+
         r3->r0+
         r3->r1+
         r3->r2+
         r4->r0+
         r4->r1+
         r5->r2+
         r6->r0+
         r6->r1+
         r6->r2+
         r6->r4+
         r7->r0+
         r7->r2+
         r7->r3+
         r7->r5+
         r7->r6+
         r8->r1+
         r8->r3+
         r8->r5+
         r8->r7+
         r9->r0+
         r9->r1+
         r9->r2+
         r9->r3+
         r9->r5+
         r9->r7+
         r9->r8+
         r10->r1+
         r10->r2+
         r10->r3+
         r10->r5+
         r10->r7+
         r10->r9+
         r11->r3+
         r11->r4+
         r11->r9+
         r11->r10+
         r12->r11+
         r13->r2+
         r13->r7+
         r13->r8+
         r13->r9+
         r13->r10+
         r13->r11+
         r13->r12}

//*************************
//***Contexts signatures***
//*************************
one sig c0, c1, c2, c3, c4, c5, c6, c7, c8, c9 extends Context{}{}

//************************
//***Request signatures***
//************************
one sig req0 extends Request{}{
sub=s0
res=r0
}
//**********************
//***      Rules     ***
//**********************
one sig rule0 extends Rule{}{
    s =s12
    t =r9
    m = prohibition
    p = 4
    c = c3+c7+c0+c4+c2+c6
}
one sig rule1 extends Rule{}{
    s =s7
    t =r13
    m = permission
    p = 4
    c = c3+c5+c6+c1+c9
}
one sig rule2 extends Rule{}{
    s =s3
    t =r4
    m = permission
    p = 4
    c = c9
}
one sig rule3 extends Rule{}{
    s =s5
    t =r5
    m = prohibition
    p = 0
    c = c9+c0+c3+c4+c8
}
one sig rule4 extends Rule{}{
    s =s12
    t =r3
    m = permission
    p = 1
    c = c5+c8+c7+c1
}
one sig rule5 extends Rule{}{
    s =s4
    t =r0
    m = prohibition
    p = 0
    c = c6+c8+c0+c5+c4+c7+c1
}
one sig rule6 extends Rule{}{
    s =s3
    t =r4
    m = prohibition
    p = 1
    c = c9+c5+c6+c0+c3+c4
}
one sig rule7 extends Rule{}{
    s =s11
    t =r2
    m = prohibition
    p = 0
    c = c0+c8+c2
}
one sig rule8 extends Rule{}{
    s =s1
    t =r2
    m = permission
    p = 1
    c = c1+c7+c3+c8+c0+c5
}
one sig rule9 extends Rule{}{
    s =s2
    t =r10
    m = permission
    p = 4
    c = c7+c3+c8+c0+c9
}
one sig rule10 extends Rule{}{
    s =s12
    t =r2
    m = permission
    p = 3
    c = c8+c5+c4
}
one sig rule11 extends Rule{}{
    s =s8
    t =r10
    m = prohibition
    p = 0
    c = c1+c2
}
one sig rule12 extends Rule{}{
    s =s4
    t =r1
    m = prohibition
    p = 4
    c = c3+c7+c0+c2+c8
}
//**************************
//***Auxiliary Predicates***
//**************************
pred access_condition[req:Request,con:Context]{
    (no  r:applicableRules[req] |  (evalRuleCond[r,con] and r.m=prohibition and
        all rule: r.^(req.ruleSucc) | not evalRuleCond[rule,con])	)
    and some { r:applicableRules[req] |evalRuleCond[r,con]}
}

//***************************
//***Determination of the ***
//***conditions (contexts)***
//***************************

one sig GrantingContext{
        acc: set Context
}{}

pred grantingContextDet[req:Request]{
        all c: Context | access_condition[req,c] <=> c in GrantingContext.acc
}
//*** determination command ***
run grantingContextDetermination{grantingContextDet[req0]} for 4 but 1 GrantingContext