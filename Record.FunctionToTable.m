let func = 

(FunctionRecord as record) =>
let
    Source = Record.ToTable(FunctionRecord),
    Meta = Table.AddColumn(Source, "Meta", each Value.Metadata(Value.Type([Value]))),
    ColNames1 = Record.FieldNames(Record.Combine(Meta[Meta])),
    #"Expanded Meta" = Table.ExpandRecordColumn(Meta, "Meta", ColNames1),
    Expand1 = Table.ExpandListColumn(#"Expanded Meta", "Documentation.Examples"),
    ColNames2 = Record.FieldNames(Record.Combine(List.Select(Expand1[Documentation.Examples], each _<>null))),
    #"Expanded Documentation.Examples1" = Table.ExpandRecordColumn(Expand1, "Documentation.Examples", ColNames2),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded Documentation.Examples1",{"Value"})
in
    #"Removed Columns"

, documentation = [
Documentation.Name =  " fnRecordFunctionsToTable
", Documentation.Description = " Transforms the function-record to a searcheable table showing metadata
", Documentation.Category = " Record.Transformation
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 1) Reference function-record as parameter
" , Code = " Check this blogpost explaining how it works: http://wp.me/p6lgsG-Gx
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
