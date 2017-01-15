hack_generics_placeholder:
	  type { $$ = $1; }
	| type T_AS type { $$ = PhackNode\GenericsConstraint[$1, PhackNode\GenericsConstraint::AS, $3]; }
	| type T_SUPER type { $$ = PhackNode\GenericsConstraint[$1, PhackNode\GenericsConstraint::SUPER, $3]; }
;

hack_generics_placeholder_list:
	  hack_generics_placeholder { $$ = init($1); }
	| hack_generics_placeholder_list ',' hack_generics_placeholder { $$ = push($1, $3); }
;

hack_non_optional_generics_placeholder_list:
	  '<' hack_generics_placeholder_list '>' { $$ = $2; }
;

hack_optional_generics_placeholder_list:
	  /* empty */ { $$ = null; }
	| hack_non_optional_generics_placeholder_list { $$ = $1; }
;



hack_type_list:
	  type { $$ = init($1); }
	| hack_type_list ',' type { $$ = push($1, $3); }
;

hack_enum:
	  T_STRING '=' scalar ';' { $$ = Node\Const_[$1, $3]; }
;


hack_non_empty_enum_list:
	  hack_enum { init($1); }
	| hack_non_empty_enum_list hack_enum { push($1, $2); }
;

hack_enum_list:
	  /* empty */ { init(); }
	| hack_non_empty_enum_list { $$ = $1; }
;

hack_user_attribute:
	  name	{ $$ = PhackNode\UserAttribute[$1, init()]; }
	| name '(' array_pair_list ')' { $$ = PhackNode\UserAttribute[$1, $3]; }
;

hack_user_attributes:
	  hack_user_attribute { $$ = init($1); }
	| hack_user_attributes ',' hack_user_attribute { $$ = push($1, $3); }
;

hack_user_attributes_list:
	  T_SL hack_user_attributes T_SR	{ $$ = $2; }
	| hack_user_attributes_list T_SL hack_user_attributes T_SR { $$ = array_merge($1, $3); }
;

hack_lambda_arguments:
	  T_VARIABLE { $$ = init(Node\Param[parseVar($1), null, null, false, false]); }
	| T_LAMBDA_OP parameter_list T_LAMBDA_CP { $$ = $2; }
;

hack_lambda:
	  hack_lambda_arguments T_LAMBDA_ARROW expr { $$ = PhackExpr\Lambda[$1, init(Stmt\Return_[$3])]; }
	| hack_lambda_arguments T_LAMBDA_ARROW '{' inner_statement_list '}' { $$ = PhackExpr\Lambda[$1, $4]; }
;

hack_non_empty_parameter_type_list:
	  type { $$ = init($1); }
	| hack_non_empty_parameter_type_list ',' type { $$ = push($1, $3); }
;

hack_parameter_type_list:
	  /* empty */ { $$ = init(false); }
	| T_ELLIPSIS { $$ = init(true); }
	| hack_non_empty_parameter_type_list { $$ = push($1, false); }
	| hack_non_empty_parameter_type_list ',' T_ELLIPSIS { $$ = push($1, true); }
;

hack_parameter_list:
	  hack_non_empty_parameter_list { $$ = $1; }
	| hack_non_empty_parameter_list ',' { $$ = $1; }
	| /* empty */ { $$ = array(); }
;

hack_non_empty_parameter_list:
	  hack_parameter { init($1); }
	| hack_non_empty_parameter_list ',' hack_parameter { push($1, $3); }
;

hack_parameter:
	  hack_optional_visibility_modifier optional_param_type optional_ref optional_ellipsis
	  T_VARIABLE { $$ = PhackNode\Param[parseVar($5), null, $2, $3, $4, $1]; }
	| hack_optional_visibility_modifier optional_param_type optional_ref optional_ellipsis
	  T_VARIABLE '=' expr { $$ = PhackNode\Param[parseVar($5), $7, $2, $3, $4, $1]; }
;

hack_optional_visibility_modifier:
	  /* empty */ { $$ = null; }
    | T_PUBLIC { $$ = Stmt\Class_::MODIFIER_PUBLIC; }
    | T_PROTECTED { $$ = Stmt\Class_::MODIFIER_PROTECTED; }
    | T_PRIVATE { $$ = Stmt\Class_::MODIFIER_PRIVATE; }
;

property_declaration:
	  type T_VARIABLE { $$ = PhackStmt\PropertyProperty[parseVar($2), null, $1]; }
	| type T_VARIABLE '=' expr { $$ = PhackStmt\PropertyProperty[parseVar($2), $4, $1]; }
;

parameter_list:
	  non_empty_parameter_list ',' { $$ = $1; }
;

argument_list:
	  '(' non_empty_argument_list ',' ')' { $$ = $2; }
;

type:
	  '?' type { $$ = PhackNode\SoftNullableType[$2, false, true]; }
	| '@' type { $$ = PhackNode\SoftNullableType[$2, true, false]; }
	| name '<' hack_type_list '>' { $$ = PhackNode\GenericsType[$1, $3]; }
	| T_ARRAY '<' hack_type_list '>' { $$ = PhackNode\GenericsType['array', $3]; }
	| '(' T_FUNCTION optional_ref '(' hack_parameter_type_list ')' optional_return_type ')'
	    { $$ = PhackNode\CallableType[$5, $7, $3]; }
	| T_VECTOR '<' hack_type_list '>' { $$ = PhackNode\GenericsType['Vector', $3]; }
	| T_IMMVECTOR '<' hack_type_list '>' { $$ = PhackNode\GenericsType['ImmVector', $3]; }
	| T_MAP '<' hack_type_list '>' { $$ = PhackNode\GenericsType['Map', $3]; }
	| T_IMMMAP '<' hack_type_list '>' { $$ = PhackNode\GenericsType['ImmMap', $3]; }
	| T_SET '<' hack_type_list '>' { $$ = PhackNode\GenericsType['Set', $3]; }
	| T_IMMSET '<' hack_type_list '>' { $$ = PhackNode\GenericsType['ImmSet', $3]; }
	| T_PAIR '<' hack_type_list '>' { $$ = PhackNode\GenericsType['Pair', $3]; }
;

class_declaration_statement:
	  class_entry_type T_STRING hack_non_optional_generics_placeholder_list
	  extends_from implements_list '{' class_statement_list '}'
	      { $$ = PhackStmt\Class_[$2, ['type' => $1, 'extends' => $4,
	                                   'implements' => $5, 'stmts' => $7,
	                                   'generics' => $3]]; }
	| hack_user_attributes_list
	  class_entry_type T_STRING hack_optional_generics_placeholder_list
	  extends_from implements_list '{' class_statement_list '}'
	      { $$ = PhackStmt\Class_[$3, ['type' => $2, 'extends' => $5,
	                                   'implements' => $6, 'stmts' => $8,
	                                   'generics' => $4, 'user_attributes' => $1]]; }

	| hack_user_attributes_list T_ENUM T_STRING ':' T_STRING '{' hack_enum_list '}'
	      { $$ = PhackStmt\Enum[$3, $5, $7]; }
	| T_ENUM T_STRING ':' T_STRING '{' hack_enum_list '}'
	      { $$ = PhackStmt\Enum[$2, $4, $6]; }
;

class_statement:
	  method_modifiers T_FUNCTION optional_ref identifier hack_optional_generics_placeholder_list
	  '(' hack_parameter_list ')' optional_return_type method_body
	      { $$ = PhackStmt\ClassMethod[$4, ['type' => $1, 'byRef' => $3, 'params' => $7,
	                                        'returnType' => $9, 'stmts' => $10,
	                                        'generics' => $5]]; }
	| hack_user_attributes_list
	  method_modifiers T_FUNCTION optional_ref identifier hack_optional_generics_placeholder_list
	  '(' hack_parameter_list ')' optional_return_type method_body
	      { $$ = PhackStmt\ClassMethod[$5, ['type' => $2, 'byRef' => $4, 'params' => $8,
	                                        'returnType' => $10, 'stmts' => $11,
	                                        'generics' => $6, 'user_attributes' => $1]]; }
;

function_declaration_statement:
	  T_FUNCTION optional_ref T_STRING hack_non_optional_generics_placeholder_list
	  '(' parameter_list ')' optional_return_type '{' inner_statement_list '}'
	      { $$ = PhackStmt\Function_[$3, ['byRef' => $2, 'params' => $6,
	                                      'returnType' => $8, 'stmts' => $10,
	                                      'generics' => $4]]; }
	| hack_user_attributes_list
	  T_FUNCTION optional_ref T_STRING hack_optional_generics_placeholder_list
	  '(' parameter_list ')' optional_return_type '{' inner_statement_list '}'
	      { $$ = PhackStmt\Function_[$4, ['byRef' => $3, 'params' => $7,
	                                      'returnType' => $9, 'stmts' => $11,
	                                      'generics' => $5, 'user_attributes' => $1]]; }
;

reserved_non_modifiers:
	T_ENUM
;

variable:
	  T_PIPE_VAR { $$ = PhackExpr\PipeVar[]; }
	| dereferencable T_NULLSAFE property_name        { $$ = PhackExpr\NullSafePropertyFetch[$1, $3]; }
;

expr:
	  hack_lambda { $$ = $1; }
	| expr T_PIPE expr { $$ = PhackExpr\Pipe[$1, $3]; }
	
;


callable_variable:
  	dereferencable T_NULLSAFE property_name argument_list
          { $$ = PhackExpr\NullSafeMethodCall[$1, $3, $4]; }
;  



hack_alias_declaration_statement:
	T_TYPE T_STRING '=' type	 {  $$ = PhackStmt\Alias[$2, $4];}
;

new_variable:
     new_variable T_NULLSAFE property_name          { $$ = PhackExpr\NullSafePropertyFetch[$1, $3]; }
;


non_empty_statement:
	hack_alias_declaration_statement ';'		{ $$ = $1;}
;

encaps_var:
        
    T_VARIABLE T_NULLSAFE T_STRING                 { $$ = PhackExpr\NullSafePropertyFetch[Expr\Variable[parseVar($1)], $3]; }
                              
;
			
dereferencable_scalar:
      T_SHAPE '(' shape_pair_list ')'		          { $$ = new PhackExpr\Shape($3); }
	 | T_MAP '{' map_pair_list '}'				{ $$ = new PhackExpr\Map($3); }
	 | T_IMMMAP '{' map_pair_list '}'				{ $$ = new PhackExpr\ImmMap($3); }
     | T_VECTOR '{' vector_list '}'					{ $$ = new PhackExpr\Vector($3); }
     | T_IMMVECTOR '{' vector_list '}'					{ $$ = new PhackExpr\ImmVector($3); }
     | T_SET '{' vector_list '}'					{ $$ = new PhackExpr\Set($3); }
     | T_IMMSET '{' vector_list '}'					{ $$ = new PhackExpr\ImmSet($3); }
     | T_PAIR '{' expr ',' expr '}'						{ $$ = new PhackExpr\Pair($3, $5); }
			
shape_pair_list:
      /* empty */                                           { $$ = array(); }
    | non_empty_shape_pair_list optional_comma              { $$ = $1; }
;

non_empty_shape_pair_list:
      non_empty_shape_pair_list ',' shape_pair              { push($1, $3); }
    | shape_pair                                            { init($1); }
;

shape_pair:
      expr T_DOUBLE_ARROW type                { $$ = PhackExpr\ShapeItem[$1, $3]; }
;
	
vector_list:
      /* empty */                                           { $$ = array(); }
    | non_empty_vector_list optional_comma              { $$ = $1; }
;

non_empty_vector_list:
      non_empty_vector_list ',' expr              { push($1, $3); }
    | expr                                            { init($1); }
;


map_pair_list:
      /* empty */                                           { $$ = array(); }
    | non_empty_map_pair_list optional_comma              { $$ = $1; }
;

non_empty_map_pair_list:
      non_empty_map_pair_list ',' map_pair              { push($1, $3); }
    | array_pair                                            { init($1); }
;

map_pair:
      expr T_DOUBLE_ARROW expr                              { $$ = PhackExpr\MapItem[$3, $1]; }	
			
