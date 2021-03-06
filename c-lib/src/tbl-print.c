/*
 * tbl_print.c - type table value printer
 *
 *
 * Mike Sample
 *
 * Copyright (C) 1993 Michael Sample
 *            and the University of British Columbia
 * This library is free software; you can redistribute it and/or
 * modify it provided that this copyright/license information is retained
 * in original form.
 *
 * If you modify this file, you must clearly indicate your changes.
 *
 * This source code is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */

#include "config.h"
#include <stdio.h>
#ifdef TTBL
#include "tbl-incl.h"

static int indentIncrG = 2;

/*
 * Print value v to file f as though it is of type modName.typeName in
 * table tbl.
 */
void
TblPrintValue PARAMS ((tbl, modName, typeName, f, v),
    TBL *tbl _AND_
    char *modName _AND_
    char *typeName _AND_
    FILE *f _AND_
    AVal *v)
{
    TBLTypeDef *tblTd;
    TBLModule *tblMod;

    tblTd = TblFindTypeDef (tbl, modName, typeName, &tblMod);

    if (tblTd == NULL)
    {
        TblError ("TblEncode: Could not find a type definition with the given module and name");
    }
    else
    {
        fprintf (f, "value %s.%s ::= \n", tblMod->name.octs, typeName);
        TblPrintTypeValue (tblTd->type, f, v, 0);
    }

}  /* TblPrint */

/*
 * starts using indent after first newline printed by this routine
 */
void
TblPrintTypeValue PARAMS ((tblT, f, v, indent),
    TBLType *tblT _AND_
    FILE *f _AND_
    AVal *v _AND_
    unsigned short indent)
{
    AVal *elmtV;
    AsnList *lVal;
    unsigned int currElmt;
    TBLType *listElmtType;
    TBLType *structElmtType;
    TBLType *choiceElmtType;
    AChoiceVal *cVal;
    AStructVal *sVal;
    void *tmp;

    switch (tblT->typeId)
    {
      case TBL_TYPEREF:
          TblPrintTypeValue (tblT->content->a.typeRef->typeDefPtr->type, f, v, indent);
          break;

      case TBL_SEQUENCE:
      case TBL_SET:
          fprintf (f,"{\n");
          currElmt = 0;
          sVal = (AStructVal*)v;
          tmp = CURR_LIST_NODE (tblT->content->a.elmts);
          FOR_EACH_LIST_ELMT (structElmtType, tblT->content->a.elmts)
          {
              Indent (f, indent+indentIncrG);
              elmtV = sVal[currElmt++];
              if (!(structElmtType->optional && (elmtV == NULL)))
              {
                  if (structElmtType->fieldName.octs != NULL)
                      fprintf (f,"%s ", structElmtType->fieldName.octs);

                  TblPrintTypeValue (structElmtType, f, elmtV, indent+indentIncrG);

                  if (structElmtType != LAST_LIST_ELMT (tblT->content->a.elmts))
                      fprintf (f,",\n");
                  else
                      fprintf (f,"\n");
              }
          }
          /* restore list curr in case recursive type */
          SET_CURR_LIST_NODE (tblT->content->a.elmts, tmp);
          Indent (f,indent);
          fprintf (f,"}");
          break;

      case TBL_SEQUENCEOF:
      case TBL_SETOF:
          fprintf (f,"{\n");
          lVal = (AsnList*)v;
          listElmtType = FIRST_LIST_ELMT (tblT->content->a.elmts);
          tmp = CURR_LIST_NODE (tblT->content->a.elmts);
          FOR_EACH_LIST_ELMT (elmtV, lVal)
          {
              Indent (f, indent+indentIncrG);
              TblPrintTypeValue (listElmtType, f, elmtV, indent+indentIncrG);
              if (elmtV != LAST_LIST_ELMT (lVal))
                  fprintf (f,",\n");
              else
                  fprintf (f,"\n");
          }
          /* restore old list curr ptr */
          SET_CURR_LIST_NODE (tblT->content->a.elmts, tmp);
          Indent (f,indent);
          fprintf (f,"}");
        break;

      case TBL_CHOICE:
          cVal = (AChoiceVal*) v;
          choiceElmtType = (TBLType*)GetAsnListElmt (tblT->content->a.elmts, cVal->choiceId);
          if (choiceElmtType->fieldName.octs != NULL)
              fprintf (f,"%s ", choiceElmtType->fieldName.octs);
          TblPrintTypeValue (choiceElmtType, f, cVal->val, indent+indentIncrG);
        break;

      case TBL_BOOLEAN:
          PrintAsnBool (f, (AsnBool*)v,indent);
        break;

      case TBL_INTEGER:
      case TBL_ENUMERATED:
          PrintAsnInt (f, (AsnInt*)v, indent);
        break;

      case TBL_BITSTRING:
          PrintAsnBits (f, (AsnBits*)v, indent);
        break;

      case TBL_OCTETSTRING:
           PrintAsnOcts (f, (AsnOcts*)v, indent);
        break;

      case TBL_NULL:
          PrintAsnNull (f, (AsnNull*)v, indent);
        break;

      case TBL_OID:
          PrintAsnOid (f, (AsnOid*)v, indent);
        break;

      case TBL_REAL:
          PrintAsnReal (f, (AsnReal*)v, indent);
        break;

      default:
         fprintf (f, "<ERROR - unknown type!>");
    }

}  /* TblPrintTypeValue */

#endif /* TTBL */
