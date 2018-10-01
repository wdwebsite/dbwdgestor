 
-- MySQL Script gerado por MySQL Workbench
-- Model: Novo modelo   Version: 2.0
-- Modificado por: Wagner Danielli
-- Sistema WDGestor
-- Data 20-02-2018 - Tabela cadastro pessoas provisória

-----------------------------------------------------------------------
/*
NORMAS DE CRIAÇÃO DOS OBJETOS DE DADOS QUE IREMOS SEGUIR

Nome                 ABREV.    Exemplo 
TABLE                TB_       TB_NOMEDATABELA
PRIMARY KEY          PK_       PK_NOMEDATABELA
FOREING KEY          FK_       FK_NOMEDATABELAPAI_NOMEDATABELAFILHA
UNIQUE KEY           UK_       UK_NOMEDATABELA
DEFAULT              DF_       DF_NOMEDATABELA_NOMEDACOLUNA
CHECK CONSTRAINT     CK_       CK_NOMEDATABELA_NOMEDACOLUNA
INDEX                ID_       IN_NOMEDATABELA_NOME(S)DA(S)COLUNA(S)
SEQUENCE             SQ_       SQ_NOMEDATABELA_NOMEDACOLUNA
VIEW                 VW_       VW_NOMEDAVIEW
PROCEDURE            PC_       PC_NOMEDAPROCEDURE
FUNCTION             FC_       FC_NOMEDAFUNCTION


DATA                 DT_       DT_CADASTRO
DESCRIÇÃO            DS_       DS_OBSERVACAO
HORA                 HR_       HR_CHEGADA
IMAGEM               IM_       IM_IMPRESSAO_DIGITAL
NOME                 NO_       NO_PESSOA
NÚMERO               NU_       NU_CPF
QUANTIDADE           QT_       QT_ESTOQUE_ATUAL
SIGLA                SG_       SG_UF
SITUAÇÃO DE STATUS   ST_       ST_REGISTRO_ATIVO
TAXA                 TX_       TX_JURO_INVESTIMENTO
TIPO                 TP_       TP_ASSUNTO
VALOR                VL_       VL_PAGAMENTO
CHAVE PRIMÁRIA       CO_SEQ_   CO_SEQ_PESSOA
CHAVE ESTRANGEIRA    CO_       CO_PESSOA
*/
-----------------------------------------------------------------------

-- Relação das tabelas e dos identificadores de tabelas;

/*
Table `WDGESTOR.`PERMISSOES` - Identificador da tabela PERM
Table `WDGESTOR.`PERMISSOES` - Identificador da tabela PERM

*/


-----------------------------------------------------------------------
/*
Regras gerais para desenvolvimento do banco de dados
*
* Campos numéricos como cnpj cpf e outros - Estes devem conter apenas numeros, traços e virgulas devem conter na mascara da aplicação
* Tamanho dos campos - Os campos devem conter o tamanho exato do maximo de caracteres ou folgas pequenas ex: CNPJ são max 14 digitos então não pode conter mais do que 14 caracteres;
* Todo tipo de chave, primaria, extrangeira entre outras precisa ser declarada a constraint para que o código fique muito mais organizado e referenciado;
* Toda tabela precisa ter a referencia TB_ antes do nome da tabela para identificar que é uma tabela;


*/

-- -----------------------------------------------------
-- BANCO DE DADOS GESTOR
-- -----------------------------------------------------

----------------
-- CRIANDO O BANCO DE DADOS - WDGESTOR
----------------
CREATE SCHEMA IF NOT EXISTS `WDGESTOR` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `WDGESTOR`;

-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`WD_G_USER` - Identificador da tabela - GUS
-- Table `WD_ERP`.`GRUPO_USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`WD_G_USER` (
  `CO_SEQ_ID_GUS` INT NOT NULL COMMENT 'Identificador da Tabela, chave primária.',
  `NO_NOME_GUS` VARCHAR(100) NULL COMMENT 'Descrição do campo Grupo Usuário',
  `ST_STATUS_GUS` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
   PRIMARY KEY (`PK_ID_GUS`))
   ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`WD_USER` - identificador da tabela - US
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`WD_USER` (
  `CO_SEQ_ID_US` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `NO_NOME_US` VARCHAR(100) NULL COMMENT 'Nome do usuário',
  `NO_EMAIL_US` VARCHAR(100) NULL COMMENT 'Email do usuário',
  `DS_SENHA_US` VARCHAR(100) NULL COMMENT 'Senha do usuário',
  `IM_FOTO_US` LONGTEXT NULL COMMENT 'Foto do usuário',
  `DT_DATA_NAS_US` DATE NULL COMMENT 'Data de nascimento do usuário',
  `ST_STATUS_US` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  `CO_ID_US` INT NOT NULL COMMENT 'Relacionamento com a tabela grupo do usuário - CO_SEQ_ID_GUS',
  PRIMARY KEY (`CO_SEQ_ID_US`, `CO_ID_US`),
  INDEX `fk_CO_SEQ_ID_GUS_idx` (`CO_ID_US` ASC),
  CONSTRAINT `fk_CO_SEQ_ID_GUS` 
    FOREIGN KEY (`CO_ID_US`)
    REFERENCES `WDGESTOR`.`WD_G_USER` (`CO_SEQ_ID_GUS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

	
-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`TB_PESSOA` - Identificador da tabela PESS
-- Tabela provisória banco de dados pessoa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`TB_PESS` (
  `CO_SEQ_ID_PESS` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela Pessoa, chave primária.',
  `DT_CAD_PESS` DATE COMMENT 'Data de Cadastro',
  `DT_NAS_PESS` DATE COMMENT 'Data de Nascimento ou fundação da empresa',  
  `NO_NOME_PESS` VARCHAR(250) NULL COMMENT 'Nome Completo fisica ou Razão social.',
  `NO_NOME_FANT_PESS` VARCHAR(250) NULL COMMENT 'Nome Fantasia quando for entidade Juridica.',  
  `NO_CONTATO_PESS` VARCHAR(100) NULL COMMENT 'Nome pessoa de contato caso seja empresa', 
  `NO_APELIDO_PESS` VARCHAR(60) NULL COMMENT 'Apelido ou nome de mais fácil identificação',  
  `TP_ENTI_TIPO_PESS` VARCHAR(1) NULL DEFAULT'N' COMMENT 'Tipo da entidade F = Fisica ou J = Juridica ou N = Não especificada',
    -- Contatos telefônicos separados
  `NU_DDD1_PESS` INT(2) DEFAULT'61' COMMENT 'DDD1 do Pessoa',
  `NU_TEL1_PESS` INT(9) COMMENT 'Tel1 da Pessoa ',
  `NU_DDD2_PESS` INT(2) DEFAULT'61' COMMENT 'DDD2 da pessoa',
  `NU_TEL2_PESS` INT(9) COMMENT 'Tel2 da pessoa',
  `NU_DDD_CEL1_PESS` INT(2) DEFAULT'61' NULL COMMENT 'DDD1 cel pessoa',
  `NU_CEL1_PESS` INT(9) COMMENT 'Cel 1 pessoa',
  `NU_DDD_CEL2_PESS` INT(2) DEFAULT'61' NULL COMMENT 'DDD2 cel pessoa',
  `NU_CEL2_PESS` INT(9) COMMENT 'Cel2 pessoa',
  `NU_DDD_CEL3_PESS` INT(2) DEFAULT'61' NULL COMMENT 'DDD3 cel pessoa',
  `NU_CEL3_PESS` INT(9) COMMENT 'Cel3 pessoa',  
    -- Número dos documentos
  `NU_CPF_PESS` VARCHAR(11) NULL COMMENT 'CPF para nota ou quando necessário - SÓ NUMEROS',
  `NU_IDENT_RG_PESS` VARCHAR(16) NULL COMMENT 'Identidade do cliente pessoa fisica.',  
  `NU_CNPJ_PESS` VARCHAR(14) NULL COMMENT 'CNPJ para nota ou quando necessário - SÓ NUMEROS',  
  `NU_INSC_EST_PESS` VARCHAR(16) NULL COMMENT 'Inscrição estadual quando for entidade Juridica.',
  `NU_INSC_MUN_PESS` VARCHAR(25) NULL COMMENT 'Inscrição municipal quando for entidade Juridica.',
    -- Dados do endereço 
  `NO_END_PESS` VARCHAR(50) NULL COMMENT 'Endereço completo',
  `DS_NUM_PESS` VARCHAR(10) NULL COMMENT 'Descrição do número do endereço.',
  `NO_BAIRRO_PESS` VARCHAR(40) NULL COMMENT 'Bairro do endereço',  
  `NO_CIDADE_PESS` VARCHAR(25) NULL COMMENT 'Cidade',
  `NO_ESTADO_PESS` VARCHAR(2) NULL COMMENT 'Estado',
  `NO_CEP_PESS` VARCHAR(8) NULL COMMENT 'Cep completo só numeros',  
    -- Outros dados
  `DS_OBS_PESS` VARCHAR(250) NULL COMMENT 'Comentários extras e observações a serem feitas',    
  `NO_SITE_PESS` VARCHAR(100) NULL COMMENT 'Site quando for entidade Juridica.',
  `TP_SEXO_PESS` VARCHAR(1) NULL DEFAULT'N' COMMENT 'Sexo quando for pessoa Fisica. M - Masculino e F - Feminino e N - Não declarado',
  `DS_EMAIL_PESS` VARCHAR(70) NULL COMMENT 'Email quando for entidade Fisica ou Jurídica',
    -- Status para aparecimentos em tabelas
  `ST_CLIENTES_PESS` INT(1) NULL DEFAULT'0' COMMENT 'Status Entrar na lista de cliente 0 - não ou 1 - sim',
  `ST_AG_TEL_PESS` INT(1) NULL DEFAULT'0' COMMENT 'Status da participação do registro AGENDA TELEFONICA 0 - não ou 1 - sim',
  `ST_FORN_PESS` INT(1) NULL DEFAULT'0' COMMENT 'Status da participação do registro FORNECEDORES 0 - não ou 1 - sim',
  `ST_FUNC_PESS` INT(1) NULL DEFAULT'0' COMMENT 'Status da participação do registro FUNCIONARIOS 0 - não ou 1 - sim',  
  `NO_USUARIO_PESS` VARCHAR(50) NULL COMMENT 'Nome do usuário do sistema',  
  `ST_USU_SIS_PESS` INT(1) NULL DEFAULT'0' COMMENT 'Status da participação do registro USUARIO SISTEMA 0 - não ou 1 - sim',
    -- Chaves dos campos
  CONSTRAINT `PK_CHAVE_PESS` PRIMARY KEY (`CO_SEQ_ID_PESS`),
  -- Breve deve ser montada chave estrangeira dos seguintes modulos dessa tabela:
  CONSTRAINT `UK_NO_APELIDO_PESS` UNIQUE (`NO_APELIDO_PESS`),
  CONSTRAINT `UK_NU_TEL1_PESS` UNIQUE (`NU_TEL1_PESS`),
  CONSTRAINT `UK_NU_TEL2_PESS` UNIQUE (`NU_TEL2_PESS`), 
  CONSTRAINT `UK_NU_CEL1_PESS` UNIQUE (`NU_CEL1_PESS`),
  CONSTRAINT `UK_NU_CEL2_PESS` UNIQUE (`NU_CEL2_PESS`),
  CONSTRAINT `UK_NU_CEL3_PESS` UNIQUE (`NU_CEL3_PESS`),
  CONSTRAINT `UK_NU_CPF_PESS` UNIQUE (`NU_CPF_PESS`),
  CONSTRAINT `UK_NU_IDENT_RG_PESS` UNIQUE (`NU_IDENT_RG_PESS`),
  CONSTRAINT `UK_NU_CNPJ_PESS` UNIQUE (`NU_CNPJ_PESS`),
  CONSTRAINT `UK_NU_INSC_EST_PESS` UNIQUE (`NU_INSC_EST_PESS`)
  )
  -- Primeiras inserções de teste de código
     --- Tabela 1 testes corretos inserindo dados
    INSERT INTO TB_PESS (`DT_CAD_PESS`, `DT_NAS_PESS`, `NO_NOME_PESS`, `NO_NOME_FANT_PESS`, 
      `NO_CONTATO_PESS`, `NO_APELIDO_PESS`, `TP_ENTI_TIPO_PESS`, `NU_DDD1_PESS`, `NU_TEL1_PESS`,
      `NU_DDD2_PESS`, `NU_TEL2_PESS`, `NU_DDD_CEL1_PESS`, `NU_CEL1_PESS`,  
      `NU_CEL2_PESS`, `NU_CEL3_PESS`, `NU_CPF_PESS`, `NU_IDENT_RG_PESS`, `NU_CNPJ_PESS`,
      `NU_INSC_EST_PESS`, `NU_INSC_MUN_PESS`, `NO_END_PESS`, `DS_NUM_PESS`, `NO_BAIRRO_PESS`, `NO_CIDADE_PESS`,
      `NO_ESTADO_PESS`, `NO_CEP_PESS`, `DS_OBS_PESS`, `NO_SITE_PESS`, `TP_SEXO_PESS`, `DS_EMAIL_PESS`, 
      `ST_CLIENTES_PESS`, `ST_AG_TEL_PESS`, `ST_FORN_PESS`, `NO_USUARIO_PESS`, `ST_USU_SIS_PESS`) 
        VALUES('2018-02-22', '1979-10-25', 'Wagner Danielli', 'NULO', 'NULO', 'WDwebsite', 'F', '61', 36125299, 61, 
        36125027, 61, 999376746, 999377733, 999885522, '85479489100', '3288216',
      '18526654000119', '1010', '10', 'Rua Fortunato Botelho', '150', 'Centro', 
      'Cristalina', 'GO', '73850000', 'Teste observação', 'www.wagnerdanielli.com.br', 'M', 'wdwebsite@gmail.com', 
      1, 1, 1, 'userwagner', 1);
      
      
	
---------- FIM DA TABELA TB_PESSOA	
  

-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`ENT_TIPO` - identificador da tabela - ETP
-- Mostra o tipo de entidade ou seja se e FISICA OU JURIDICA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`ENT_TIPO` (
  `CO_SEQ_ID_ETP` INT NOT NULL COMMENT 'Identificador da Tabela, chave primária.',
  `DS_DESC_ETP` VARCHAR(100) NULL COMMENT 'Descrição do tipo da entidade Juridica ou Fisica',
  `ST_STATUS_ETP` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  PRIMARY KEY (`CO_SEQ_ID_ETP`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`TEL_TIPO`- identificador da tabela TTP
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`TEL_TIPO` (
  `CO_SEQ_ID_TTP` INT NOT NULL COMMENT 'Identificador da Tabela, chave primária.',
  `DS_DESC_TTP` VARCHAR(100) NULL COMMENT 'Descrição do tipo de telefone: Comercial, Residencial, Celular',
  `ST_STATUS_TTP` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  PRIMARY KEY (`CO_SEQ_ID_TTP`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`END_TIPO`- identificador da tabela ITP
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`END_TIPO` (
  `CO_SEQ_ID_ITP` INT NOT NULL COMMENT 'Identificador da Tabela, chave primária.',
  `DS_DESC_IPT` VARCHAR(100) NULL COMMENT 'Descrição do tipo de endereço: Comercial, Residencial, Entrega.',
  `ST_STATUS_IPT` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  PRIMARY KEY (`CO_SEQ_ID_ITP`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`ENTIDADE` - Identificador da tabela ETD
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`ENTIDADE` (
  `CO_SEQ_ID_ETD` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `NO_NOME_ETD` VARCHAR(100) NULL COMMENT 'Nome da entidade.',
  `TP_ENTI_TIPO_ETD` VARCHAR(1) NULL COMMENT 'Tipo da entidade F = Fisica ou J = Juridica',
  `NU_CPF_CNPJ_ETD` VARCHAR(14) NULL COMMENT 'CPF ou CNPJ - Deve ser armazenado apenas o número sem traços pontos e outros apenas numeros',
  `NU_INSC_EST_ETD` VARCHAR(25) NULL COMMENT 'Inscrição estadual quando for entidade Juridica.',
  `NU_INSC_MUN_ETD` VARCHAR(25) NULL COMMENT 'Inscrição municipal quando for entidade Juridica.',
  `NO_NOME_FANT_ETD` VARCHAR(100) NULL COMMENT 'Nome Fantasia quando for entidade Juridica.',
  `NO_SITE_ETD` VARCHAR(100) NULL COMMENT 'Site quando for entidade Juridica.',
  `TP_SEXO_ETD` VARCHAR(1) NULL COMMENT 'Sexo quando for entidade Fisica.',
  `DT_NASC_ETD` DATE NULL COMMENT 'Data de Nascimento quando for entidade Fisica.',
  `DS_RG_ETD` VARCHAR(50) NULL COMMENT 'Rg quando for entidade Fisica.',
  `DS_EMAIL_ETD` VARCHAR(60) NULL COMMENT 'Email quando for entidade Fisica.',
  `ST_STATUS_ETD` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  `CO_ID_ETD` INT NOT NULL COMMENT 'Relacionamento com a tabela END_TIPO - tipo de entidade',
  PRIMARY KEY (`CO_SEQ_ID_ETD`, `CO_ID_ETD`),
  INDEX `fk_ENTIDADE_ENTIDADE_TIPO1_idx` (`CO_ID_ETD` ASC),
  CONSTRAINT `fk_ENTIDADE_ENTIDADE_TIPO1`
    FOREIGN KEY (`CO_ID_ETD`)
    REFERENCES `WDGESTOR`.`ENTIDADE` (`CO_SEQ_ID_ETD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`ENT_CONTATOS` - Identificador da tabela ECT
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`ENT_CONTATOS` (
  `CO_SEQ_ID_ECT` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `NU_DDD1_ECT` VARCHAR(2) NULL COMMENT 'DDD1 do contato',
  `NU_TEL1_ECT` VARCHAR(9) NULL COMMENT 'Telefone 1 do contato',
  `NU_DDD2_ECT` VARCHAR(2) NULL COMMENT 'DDD2 do contato',
  `NU_TEL2_ECT` VARCHAR(9) NULL COMMENT 'Telefone 2 do contato',
  `NU_DDD_CEL1_ECT` VARCHAR(2) NULL COMMENT 'DDD1 celular do contato',
  `NU_CEL1_ECT` VARCHAR(9) NULL COMMENT 'Celular 1 do contato',
  `NU_DDD_CEL2_ECT` VARCHAR(2) NULL COMMENT 'DDD2 celular do contato',
  `NU_CEL2_ECT` VARCHAR(9) NULL COMMENT 'Celular 2 do contato',
  `NU_DDD_CEL3_ECT` VARCHAR(2) NULL COMMENT 'DDD3 celular do contato',
  `NU_CEL3_ECT` VARCHAR(9) NULL COMMENT 'Celular 3 do contato',  
  `NO_CONTATO_ECT` VARCHAR(100) NULL COMMENT 'Nome do contato quando for pessoa juridica',
  `NO_EMAIL_ECT` VARCHAR(100) NULL COMMENT 'email do contato quando for pessoa juridica',
  `DS_CARGO_ECT` VARCHAR(100) NULL COMMENT 'Cargo do contato quando for pessoa juridica',
  `ST_STATUS_ECT` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  `CO_ENTIDADE_ID_ECT` INT NOT NULL COMMENT 'Relacionamento com a tabela entidade',
  `CO_TELEFONE_TIPO_ID_ECT` INT NOT NULL COMMENT 'Relacionamento com a tabela tipo de telefone',
  PRIMARY KEY (`CO_SEQ_ID_ECT`, `CO_ENTIDADE_ID_ECT`, `CO_TELEFONE_TIPO_ID_ECT`),
  INDEX `fk_ENTIDADE_CONTATOS_ENTIDADE1_idx` (`CO_ENTIDADE_ID_ECT` ASC),
  INDEX `fk_ENTIDADE_CONTATOS_TELEFONE_TIPO1_idx` (`CO_TELEFONE_TIPO_ID_ECT` ASC),
  CONSTRAINT `fk_ENTIDADE_CONTATOS_ENTIDADE1`
    FOREIGN KEY (`CO_ENTIDADE_ID_ECT`)
    REFERENCES `WDGESTOR`.`ENTIDADE` (`CO_SEQ_ID_ETD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENTIDADE_CONTATOS_TELEFONE_TIPO1`
    FOREIGN KEY (`CO_TELEFONE_TIPO_ID_ECT`)
    REFERENCES `WDGESTOR`.`END_TIPO` (`CO_SEQ_ID_ITP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`ENTIDADE_ENDERECOS` - Identificador da tabela EEN
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`ENTIDADE_ENDERECOS` (
  `CO_SEQ_ID_EEN` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `DS_PREFIXO_EEN` VARCHAR(50) NULL COMMENT 'Prefixo do endereço',
  `NO_LOG_EEN` VARCHAR(100) NULL COMMENT 'Logradouro do endereço',
  `DS_NUM_EEN` VARCHAR(30) NULL COMMENT 'Número do endereço',
  `DS_COMP_EEN` VARCHAR(100) NULL COMMENT 'Complemento do endereço',
  `DS_BAIRRO_EEN` VARCHAR(80) NULL COMMENT 'Bairro do endereço',
  `NO_CIDADE_EEN` VARCHAR(60) NULL COMMENT 'Cidade do endereço',
  `NO_UF_EEN` VARCHAR(2) NULL COMMENT 'UF do endereço dois digitos',
  `NU_CEP_EEN` VARCHAR(8) NULL COMMENT 'CEP do endereço 8 digitos',
  `NU_ENTIDADE_ID_EEN` INT NOT NULL COMMENT 'Relacionamento com a tabela entidade',
  `NO_ENDERECO_TIPO_ID_EEN` INT NOT NULL COMMENT 'Relacionamento com a tabela tipo de endereço',
  PRIMARY KEY (`CO_SEQ_ID_EEN`, `NU_ENTIDADE_ID_EEN`, `NO_ENDERECO_TIPO_ID_EEN`),
  INDEX `fk_ENTIDADE_ENDERECOS_ENTIDADE1_idx` (`NU_ENTIDADE_ID_EEN` ASC),
  INDEX `fk_ENTIDADE_ENDERECOS_ENDERECO_TIPO1_idx` (`NO_ENDERECO_TIPO_ID_EE` ASC),
  CONSTRAINT `fk_ENTIDADE_ENDERECOS_ENTIDADE1`
    FOREIGN KEY (`NU_ENTIDADE_ID_EEN`)
    REFERENCES `WDGESTOR`.`ENTIDADE` (`CO_SEQ_ID_ETD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENTIDADE_ENDERECOS_ENDERECO_TIPO1`
    FOREIGN KEY (`NO_ENDERECO_TIPO_ID_EEN`)
    REFERENCES `WDGESTOR`.`END_TIPO` (`CO_SEQ_ID_ITP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`TP_PROD_CAT` - Identificador da tabela PCT
-- Cadastro de categoria de produtos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`TB_PROD_CAT` (
-- Referencia a categoria de produtos cadastrados
  `CO_SEQ_ID_PCT` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `NO_NO_CAT_PCT` VARCHAR(100) NOT NULL COMMENT 'Descrição da Categoria - Nome da categoria do produto chave unica unique key',
  `DS_OBS_PCT` VARCHAR(250) NULL COMMENT 'Observação complementar',
  `ST_STATUS_PCT` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  CONSTRAINT `UK_NO_NO_CAT_PCT` UNIQUE KEY(NO_NO_CAT_PCT),
  CONSTRAINT `PK_CO_SEQ_ID_PCT` PRIMARY KEY (`CO_SEQ_ID_PCT`))
ENGINE = InnoDB;

-- Inserindo dados a tabela produtos
INSERT INTO TB_BROD_CAT (NO_NO_CAT_PCT, ST_STATUS_PCT) VALUES('Toner', 1);
INSERT INTO TB_BROD_CAT (NO_NO_CAT_PCT, ST_STATUS_PCT) VALUES('Cartuchos', 1);
INSERT INTO TB_BROD_CAT (NO_NO_CAT_PCT, ST_STATUS_PCT) VALUES('Cabos', 1);


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`TB_PRODUTO` - Identificador da tabela PDT
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`TB_PRODUTO` (
  `CO_SEQ_COD_PDT` INT NOT NULL COMMENT 'Identificador da Tabela, chave primária.',
  `NO_PROD_PDT` VARCHAR(100) NULL COMMENT 'Nome do produto',
  `DS_DESC_PDT` VARCHAR(150) NULL COMMENT 'Descrição do produto',
  `DS_COD_FORN_PDT` VARCHAR(150) NULL COMMENT 'Código do fornecedor',
  `DS_LOC_INTEN_PDT` VARCHAR(150) NULL COMMENT 'Localização interna do produto',
  `DS_NCM_PDT` VARCHAR(50) NULL COMMENT 'codigo NCM',
  `DS_CST_PDT` VARCHAR(50) NULL COMMENT 'C',
  `DS_CFOP_PDT` VARCHAR(50) NULL COMMENT '',
  `DS_UNIDADE_PDT` VARCHAR(50) NULL COMMENT 'Tipo de unidade ex unitario, caixa, litro etc',
  `VL_VALOR_UNITARIO_PDT` DECIMAL(10,2) NULL COMMENT 'Valor unitário do produto',
  `ST_STATUS_PDT` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  `DS_PRODUTO_CATEGORIA_ID_PDT` INT NOT NULL COMMENT'PRODUTO_CATEGORIA_ID',
  PRIMARY KEY (`CO_SEQ_COD_PDT`, `DS_PRODUTO_CATEGORIA_ID_PDT`),
  INDEX `fk_PRODUTO_PRODUTO_CATEGORIA1_idx` (`DS_PRODUTO_CATEGORIA_ID_PDT` ASC),
  CONSTRAINT `fk_PRODUTO_PRODUTO_CATEGORIA1`
    FOREIGN KEY (`DS_PRODUTO_CATEGORIA_ID_PDT`)
    REFERENCES `WDGESTOR`.`TB_PROD_CAT` (`CO_SEQ_ID_PCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserindo dados na tabela produtos;
INSERT INTO TB_PRODUTO(NO_PROD_PDT, DS_DESC_PDT) VALUES();


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`TB_QTD_PROD` - Identificador da tabela QPD
-- Tabela com dados de quantidade do produto em estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`TB_QTD_PROD` (
  `CO_SEQ_COD_QPD` INT NOT NULL COMMENT 'Identificador da Tabela, chave primária.',
  `COD_PDT_QPD` VARCHAR(100) NOT NULL COMMENT 'Código do produto chave estrangeira',
  `QTD_QPD` INT NOT NULL COMMENT 'Nome do produto',
  CONSTRAINT `PK_CO_SEQ_COD_QPD` PRIMARY KEY (`CO_SEQ_COD_QPD`),
  CONSTRAINT `FK_COD_PDT_QPD` 
    FOREIGN KEY (`COD_PDT_QPD`)
    REFERENCES `WDGESTOR`.`TB_PRODUTO` (`CO_SEQ_COD_PDT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`PEDIDO` - Identificador da tabela PD
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`PEDIDO` (
  `CO_SEQ_ID_PD` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `NO_NOME_RAZAO_SOCIAL_PD` VARCHAR(100) NULL COMMENT 'Nome ou Razao do cliente',
  `DOCUMENTO` VARCHAR(100) NULL COMMENT 'cpf ou cnpj',
  `NO_DDD1_PD` VARCHAR(100) NULL COMMENT 'DDD tel1 do cliente',
  `NU_TEL1_PD` VARCHAR(100) NULL COMMENT 'Tel1  do cliente',
  `NO_DDD2_PD` VARCHAR(100) NULL COMMENT 'DDD tel2 do cliente',
  `NU_TEL2_PD` VARCHAR(100) NULL COMMENT 'Tel2  do cliente',
  `NO_DDD_CELL1_PD` VARCHAR(100) NULL COMMENT 'DDD cel1  do cliente',
  `NU_CEL1_PD` VARCHAR(100) NULL COMMENT 'Cel1 do cliente',
  `NO_DDD_CEL2_PD` VARCHAR(100) NULL COMMENT 'DDD cel2  do cliente',
  `NU_CEL2_PD` VARCHAR(100) NULL COMMENT 'Cel2 do cliente',  
  `DS_TIPO_LOGRADOURO_PD` VARCHAR(100) NULL COMMENT 'Tipo logradouro do cliente\n',
  `DS_LOGRADOURO_PD` VARCHAR(100) NULL COMMENT 'Logradouro do cliente',
  `DS_NUMERO_PD` VARCHAR(100) NULL COMMENT 'Numero do logradouro',
  `DS_COMPLEMENTO_PD` VARCHAR(100) NULL COMMENT 'Complemento do logradouro',
  `DS_BAIRRO_PD` VARCHAR(100) NULL COMMENT 'Bairro do logradouro',
  `DS_CIDADE_PD` VARCHAR(100) NULL COMMENT 'Cidade do logradouro',
  `DS_CEP_PD` VARCHAR(8) NULL COMMENT 'cep do logradouro com 8 numeros sem traços',
  `DS_UF_PD` VARCHAR(2) NULL COMMENT 'uf do logradouro com 2 digitos',
  `DS_DATA_PEDIDO_PD` DATE NULL COMMENT 'data do pedido',
  `DS_DATA_ENTREGA_PD` DATE NULL COMMENT 'data da entrega',
  `DS_DATA_ENVIO_PD` DATE NULL COMMENT 'data do envio',
  `DS_BASE_ICMS_PD` DECIMAL(18,2) NULL COMMENT 'base icms',
  `VL_VALOR_ICMS_PD` DECIMAL(18,2) NULL COMMENT 'valor icms',
  `VL_BASE_ICMS_ST_PD` DECIMAL(18,2) NULL COMMENT 'base icms st',
  `VL_VALOR_ICMS_ST_PD` DECIMAL(18,2) NULL COMMENT 'valor icms st',
  `VL_VALOR_TOTAL_PD` DECIMAL(18,2) NULL COMMENT 'valor total',
  `VL_VALOR_FRETE_PD` DECIMAL(18,2) NULL COMMENT 'valor frete',
  `VL_VALOR_SEGURO_PD` DECIMAL(18,2) NULL COMMENT 'valor do seguro',
  `VL_VALOR_DESCONTO_PD` DECIMAL(18,2) NULL COMMENT 'valor desconto',
  `VL_OUTRAS_DESPESAS_PD` DECIMAL(18,2) NULL COMMENT 'valor outras despesas',
  `VL_VALOR_IPI_PD` DECIMAL(18,2) NULL COMMENT 'valor do ipi',
  `VL_VALOR_TOTAL_NOTA_PD` DECIMAL(18,2) NULL COMMENT 'valor total da nota',
  `VL_NATUREZA_OPERACAO_PD` VARCHAR(100) NULL COMMENT 'Natureza da operação',
  `DS_INFORMACOES_COMP_PD` VARCHAR(100) NULL COMMENT 'Informações Complementares',
  `NU_NUMERO_PEDIDO_PD` VARCHAR(100) NULL,
  `CO_ENTIDADE_ID_PD` INT NOT NULL COMMENT 'Relacionamento da tabela entidade id',
  `CO_ENTIDADE_TIPO_ID_PD` INT NOT NULL COMMENT'Relacionamento da tabela ENTIDADE TIPO',
  PRIMARY KEY (`CO_SEQ_ID_PD`),
  INDEX `fk_PEDIDO_ENTIDADE1_idx` (`ENTIDADE_ID` ASC, `CO_ENTIDADE_TIPO_ID_PD` ASC),
  CONSTRAINT `fk_PEDIDO_ENTIDADE1`
    FOREIGN KEY (`ENTIDADE_ID` , `CO_ENTIDADE_TIPO_ID_PD`)
    REFERENCES `WD_ERP`.`ENTIDADE` (`CO_SEQ_ID_ETD` , `ENTIDADE_TIPO_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`PEDIDO_DETALHE` - Identificador da tabela PED
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`PEDIDO_DETALHE` (
  `CO_SEQ_ID_PED` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `NU_COD_PROD_PED` INT NULL COMMENT 'Codigo do produto',
  `DS_DESC_PROD_PED` VARCHAR(100) NULL COMMENT 'Descrição do produto',
  `DS_NCM_PED` VARCHAR(100) NULL COMMENT 'NCM do produto codigo governo identificador do produto',
  `DS_CST_PED` VARCHAR(100) NULL COMMENT 'CST do produto',
  `DS_CFOP_PED` VARCHAR(100) NULL COMMENT 'CFOP do produto',
  `DS_UNI_PED` VARCHAR(100) NULL COMMENT 'Unidade do produto ex: unitario, caixa, outros',
  `DS_QTD_PED` VARCHAR(10) NULL COMMENT 'Quantidade do produto',
  `VL_VAL_UNI_PED` DECIMAL(8,2) NULL COMMENT 'Valor unitario do produto',
  `VL_VAL_TOT_PED` DECIMAL(8,2) NULL COMMENT 'Valor total',
  `VL_BASE_ICMS_PED` DECIMAL(8,2) NULL COMMENT 'Base do icms',
  `VL_VAL_ICMS_PED` DECIMAL(8,2) NULL COMMENT 'Valor do icms',
  `VL_VAL_IPI_PED` DECIMAL(8,2) NULL COMMENT 'Valor do ipi',
  `VL_ALIQUOTA_ICMS_PED` DECIMAL(8,2) NULL COMMENT 'Aliquota do icms',
  `VL_ALIQUOTA_IPI_PED` DECIMAL(8,2) NULL COMMENT 'Aliquota do ipi',
  `NU_PED_ID_PED` INT NOT NULL COMMENT 'ID do pedido',
  `NU_PROD_COD_PED` INT NOT NULL COMMENT 'Código do produto',
  `NU_PROD_CAT_ID_PED` INT NOT NULL COMMENT 'Categoria do produto',
  PRIMARY KEY (`CO_SEQ_ID_PED`, `NU_PED_ID_PED`, `NU_PROD_COD_PED`, `NU_PROD_CAT_ID_PED`),
  INDEX `fk_PEDIDO_DETALHE_PEDIDO1_idx` (`NU_PED_ID_PED` ASC),
  INDEX `fk_PEDIDO_DETALHE_PRODUTO1_idx` (`NU_PROD_COD_PED` ASC, `NU_PROD_CAT_ID_PED` ASC),
  CONSTRAINT `fk_PEDIDO_DETALHE_PEDIDO1`
    FOREIGN KEY (`NU_PED_ID_PED`)
    REFERENCES `WD_ERP`.`PEDIDO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEDIDO_DETALHE_PRODUTO1`
    FOREIGN KEY (`NU_PROD_COD_PED` , `NU_PROD_CAT_ID_PED`)
    REFERENCES `WD_ERP`.`PRODUTO` (`CO_SEQ_COD_PDT` , `PRODUTO_CATEGORIA_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`CNAE` - Identificador da tabela CNA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`CNAE` (
  `NU_CNAE_CNA` INT NULL,
  `DS_DESC_CNA` VARCHAR(100) NULL,
  PRIMARY KEY (`NU_CNAE_CNA`))
ENGINE = InnoDB;

-------------------------------------------------------
--           Modelagem e alteração da OS
--
-------------------------------------------------------


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`SERVICO` - Identificador da tabela SERV
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`SERVICO` (
-- Descrição do serviço executado, lembrando que uma e descrição real do serviço e outra e a descrição contida no CNAE
-- Esta descrição deve ser a que mais se encaixa no CNAE ex: troca de fonte - CNAE - numero e descrição
  `CO_SEQ_COD_SERV` INT NOT NULL COMMENT'CODIGO',
  `DS_DESC_SERV` VARCHAR(100) NULL COMMENT'DESCRICAO - Descrição real do serviço tipo cons. de fonte, troca HD outros',
  `DS_DESC_REFCNAE_SERV` VARCHAR(100) NULL COMMENT'DESCRICão do serviço referente ao CNAE que se encaixa esse serviço',
  `NU_CNAE_SERV` INT NOT NULL COMMENT'CNAE_CNAE - NUMERO DO CNAE',
  PRIMARY KEY (`CO_SEQ_COD_SERV`, `NU_CNAE_SERV`),
  INDEX `fk_SERVICO_CNAE1_idx` (`NU_CNAE_SERV` ASC),
  CONSTRAINT `fk_SERVICO_CNAE1`
    FOREIGN KEY (`NU_CNAE_SERV`)
    REFERENCES `WDGESTOR`.`CNAE` (`CNAE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`MARCAS_AP` - Identificador da tabela MAP
------ Falta configurar os detalhes chaves e outros
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`MARCAS_AP` (
-- Este e o cadastro de todas as marcas de aparelhos antes de ser cadastrado na OS
  `CO_SEQ_COD_APR` INT NOT NULL COMMENT'',
  `NO_NOME_MARCA_APR` VARCHAR(100) NOT NULL COMMENT'',
  `DS_DESC_APR` VARCHAR(100) NULL COMMENT'',
  PRIMARY KEY (`CO_SEQ_COD_APR`))
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`APARELHOS` - Identificador da tabela APR
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`APARELHOS` (
-- Esta parte e onde é cadastrado cada aparelho de forma individual para depois facilitar a busca do mesmo
  `CO_SEQ_COD_APR` INT NOT NULL COMMENT'',
  `NO_NOME_APR` VARCHAR(100) NOT NULL COMMENT'',
  `NO_NOME_APR` VARCHAR(100) NOT NULL COMMENT'',
  `NO_NOME_APR` VARCHAR(100) NOT NULL COMMENT'',
  `DS_DES_APR` VARCHAR(100) NULL,
  `DS_CNAE_APR` INT NOT NULL,
  PRIMARY KEY (`CODIGO`, `DS_CNAE_APR`),
  INDEX `fk_SERVICO_CNAE1_idx` (`DS_CNAE_APR` ASC),
  CONSTRAINT `fk_SERVICO_CNAE1`)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`ORDEM_SERVICO` - Identificador da tabela OS
----- Esta tabela inclui mais campos necessários os que devem ser ainda melhorados
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`ORDEM_SERVICO` (
  `NU_ID_OS` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `NO_NOME_RAZAO_SOCIAL_OS` VARCHAR(100) NULL COMMENT 'Nome ou Razao do cliente',
  `NU_CPF_CNPJ_OS` VARCHAR(14) NULL COMMENT 'Documento CPF ou CNPJ do cliente',
  `NU_DDD1_OS` VARCHAR(100) NULL COMMENT 'DDD  do cliente',
  `NU_TEL1_OS` VARCHAR(100) NULL COMMENT 'Telefone  do cliente',
  `NU_DDD2_OS` VARCHAR(100) NULL COMMENT 'DDD  do cliente',
  `NU_TEL2_OS` VARCHAR(100) NULL COMMENT 'Telefone  do cliente',
  `NU_DDD1_CEL_OS` VARCHAR(100) NULL COMMENT 'DDD  do cliente',
  `NU_CEL1_OS` VARCHAR(100) NULL COMMENT 'Telefone  do cliente',
  `NU_DDD2_CEL_OS` VARCHAR(100) NULL COMMENT 'DDD  do cliente',
  `NU_CEL2_OS` VARCHAR(100) NULL COMMENT 'Telefone  do cliente',
  `NU_DDD3_CEL_OS` VARCHAR(100) NULL COMMENT 'DDD  do cliente',
  `NU_CEL3_OS` VARCHAR(100) NULL COMMENT 'Telefone  do cliente',
  `NO_TIPO_LOG_OS` VARCHAR(100) NULL COMMENT 'Tipo logradouro do cliente\n',
  `NO_LOGRADOURO_OS` VARCHAR(100) NULL COMMENT 'Logradouro do cliente',
  `NU_NUM_OS` VARCHAR(100) NULL COMMENT 'Numero do logradouro',
  `NU_COMP_OS` VARCHAR(100) NULL COMMENT 'Complemento do logradouro',
  `NU_BAIRRO_OS` VARCHAR(100) NULL COMMENT 'Bairro do logradouro',
  `NO_CIDADE_OS` VARCHAR(100) NULL COMMENT 'Cidade do logradouro',
  `NU_CEP_OS` VARCHAR(100) NULL COMMENT 'cep do logradouro',
  `NU_UF_OS` VARCHAR(100) NULL COMMENT 'uf do logradouro',
  `NU_DATA_ENT_OS` DATE NULL COMMENT'Data da entrega do aparelho',
  `NU_DATA_CONC_OS` DATE NULL COMMENT'Data da conclusão do aparelho',
  `NU_NUM_ORDEM_OS` INT NULL COMMENT'Número da ordem de serviço',
  `NU_COD_VER_OS` VARCHAR(100) NULL COMMENT'Código de verificação ESSE EU NÃO SEI O QUE E',
  `DS_DESC_OS` VARCHAR(100) NULL COMMENT'Descrição do defeito',
  `DS_NAT_OPE_OS` VARCHAR(100) NULL COMMENT'Natureza da operação NA OS NÃO ENTENDI PARA QUE A NECESSIDADE',
  `NU_IR_OS` DECIMAL(8,2) NULL,
  `NU_CSLL_OS` DECIMAL(8,2) NULL,
  `NU_COFINS_OS` DECIMAL(8,2) NULL,
  `NU_PIS_OS` DECIMAL(8,2) NULL,
  `NU_INSS_OS` DECIMAL(8,2) NULL,
  `NU_CREDITO_GERADO_OS` DECIMAL(8,2) NULL,
  `NU_VALOR_SERVICO_OS` DECIMAL(8,2) NULL,
  `NU_DEDUCOES_OS` DECIMAL(18,2) NULL,
  `NU_DESC_COND_OS` DECIMAL(18,2) NULL COMMENT' DESCONTO_CONDICIONADOS - NÃO ENTENDI',
  `NU_DESC_INCOND_OS` DECIMAL(18,2) NULL COMMENT'DESCONTO_INCONDICIONADOS - NÃO ENTENDI',
  `NU_OUTRAS_RETENCOES_OS` DECIMAL(18,2) NULL,
  `NU_BASE_CALCULO_OS` DECIMAL(18,2) NULL,
  `NU_ALIQUOTA_OS` DECIMAL(18,2) NULL,
  `NU_ISS_DEVIDO_OS` DECIMAL(18,2) NULL,
  `NU_ISS_RETIDO_OS` DECIMAL(18,2) NULL,
  `VL_VAL_LIQ_OS` DECIMAL(18,2) NULL COMMENT'VALOR_LIQUIDO',
  `VL_VAL_TOT_OS` DECIMAL(18,2) NULL COMMENT'VALOR_TOTAL',
  `DS_INF_IMP_OS` VARCHAR(100) NULL COMMENT'INFORMACOES_IMPORTANTES',
  `NU_SERV_COD_OS` INT NOT NULL COMMENT'SERVICO_CODIGO',
  `NU_SERV_CNAE_OS` INT NOT NULL COMMENT'SERVICO_CNAE_CNAE',
  `NU_ENT_ID_OS` INT NOT NULL COMMENT'ENTIDADE_ID',
  `NU_ENT_TIPO_ID_OS` INT NOT NULL COMMENT'ENTIDADE_ENTIDADE_TIPO_ID',
  PRIMARY KEY (`NU_SERV_COD_OS`, `NU_SERV_CNAE_OS`),
  INDEX `fk_ORDEM_SERVICO_ENTIDADE1_idx` (`NU_ENT_ID_OS` ASC, `NU_ENT_TIPO_ID_OS` ASC),
  CONSTRAINT `fk_ORDEM_SERVICO_SERVICO1`
    FOREIGN KEY (`NU_SERV_COD_OS` , `NU_SERV_CNAE_OS`)
    REFERENCES `WDGESTOR`.`SERVICO` (`CO_SEQ_COD_SERV` , `NU_CNAE_SERV`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDEM_SERVICO_ENTIDADE1`
    FOREIGN KEY (`NU_ENT_ID_OS` , `NU_ENT_TIPO_ID_OS`)
    REFERENCES `WDGESTOR`.`ENTIDADE` (`CO_SEQ_ID_ETD` , `TP_ENTI_TIPO_ETD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`ESTOQUE` - Identificador da tabela EST
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`ESTOQUE` (
  `CO_SEQ_ID_EST` INT NOT NULL COMMENT'ID',
  `NU_QTDE_ESTOQUE_EST` INT NULL,
  `DT_DATA_EST` DATE NULL,
  `NU_PROD_COD_EST` INT NOT NULL COMMNET'PRODUTO_CODIGO',
  `NU_PROD_CAT_ID_EST` INT NOT NULL COMMENT'PRODUTO_PRODUTO_CATEGORIA_ID',
  PRIMARY KEY (`CO_SEQ_ID_EST`, `NU_PROD_COD_EST`, `NU_PROD_CAT_ID_EST`),
  INDEX `fk_ESTOQUE_PRODUTO1_idx` (`NU_PROD_COD_EST` ASC, `NU_PROD_CAT_ID_EST` ASC),
  CONSTRAINT `fk_ESTOQUE_PRODUTO1`
    FOREIGN KEY (`NU_PROD_COD_EST` , `NU_PROD_CAT_ID_EST`)
    REFERENCES `WDGESTOR`.`PRODUTO` (`CO_SEQ_COD_PDT` , `DS_PRODUTO_CATEGORIA_ID_PDT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`FUNCIONALIDADES` - Identificador da tabela FUNC
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`FUNCIONALIDADES` (
  `CO_SEQ_ID_FUNC` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `DS_DESC_FUNC` VARCHAR(100) NULL COMMENT 'Descrição da funcionalidade',
  `NU_STATUS_FUNC` INT NULL COMMENT 'Status 0 - inativo ou 1 - ativo',
  PRIMARY KEY (`CO_SEQ_ID_FUNC`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela `WDGESTOR.`PERMISSOES` - Identificador da tabela PERM
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`PERMISSOES` (
  `SEQ_CO_ID_PERM` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da Tabela, chave primária.',
  `NU_FLAG_PERM` INT NULL COMMENT 'Flag 0 - nao permitido ou 1 - permitido',
  `NU_FUNC_ID_PERM` INT NOT NULL COMMENT'FUNCIONALIDADES_ID',
  `NU_GRUPO_USUARIO_ID_PERM` INT NOT NULL COMMENT'GRUPO_USUARIO',
  PRIMARY KEY (`SEQ_CO_ID_PERM`, `NU_FUNC_ID_PERM`, `NU_GRUPO_USUARIO_ID_PERM`),
  INDEX `fk_PERMISSOES_FUNCIONALIDADES1_idx` (`NU_FUNC_ID_PERM` ASC),
  INDEX `fk_PERMISSOES_GRUPO_USUARIO1_idx` (`NU_GRUPO_USUARIO_ID_PERM` ASC),
  CONSTRAINT `fk_PERMISSOES_FUNCIONALIDADES1`
    FOREIGN KEY (`NU_FUNC_ID_PERM`)
    REFERENCES `WDGESTOR`.`FUNCIONALIDADES` (`CO_SEQ_ID_FUNC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERMISSOES_GRUPO_USUARIO1`
    FOREIGN KEY (`NU_GRUPO_USUARIO_ID_PERM`)
    REFERENCES `WD_ERP`.`GRUPO_USUARIO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`CONTAS_PAGAR_STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`CONTAS_PAGAR_STATUS` (
  `ID` INT NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`CENTRO_CUSTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`CENTRO_CUSTO` (
  `ID` INT NOT NULL,
  `CODIGO` VARCHAR(100) NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  `CONTA_CONTABIL` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`CONTAS_PAGAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`CONTAS_PAGAR` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DATA_EMISSAO` DATE NULL,
  `DATA_VENCIMENTO` DATE NULL,
  `DATA_PAGAMENTO` DATE NULL,
  `NUMERO_PARCELA` INT NULL,
  `NUMERO_TOTAL_PARCELAS` INT NULL,
  `VALOR_PAGAR` DECIMAL(18,2) NULL,
  `VALOR_DESCONTO` DECIMAL(18,2) NULL,
  `VALOR_JUROS` DECIMAL(18,2) NULL,
  `VALOR_TOTAL` DECIMAL(18,2) NULL,
  `CODIGO_BARRAS` VARCHAR(100) NULL,
  `OBSERVACAO` TEXT NULL,
  `CONTAS_PAGAR_STATUS_ID` INT NOT NULL,
  `CENTRO_CUSTO_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_CONTAS_PAGAR_CONTAS_PAGAR_STATUS1_idx` (`CONTAS_PAGAR_STATUS_ID` ASC),
  INDEX `fk_CONTAS_PAGAR_CENTRO_CUSTO1_idx` (`CENTRO_CUSTO_ID` ASC),
  CONSTRAINT `fk_CONTAS_PAGAR_CONTAS_PAGAR_STATUS1`
    FOREIGN KEY (`CONTAS_PAGAR_STATUS_ID`)
    REFERENCES `WD_ERP`.`CONTAS_PAGAR_STATUS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTAS_PAGAR_CENTRO_CUSTO1`
    FOREIGN KEY (`CENTRO_CUSTO_ID`)
    REFERENCES `WD_ERP`.`CENTRO_CUSTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`CONTAS_RECEBER_STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`CONTAS_RECEBER_STATUS` (
  `ID` INT NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`CONTAS_RECEBER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`CONTAS_RECEBER` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NUMERO_NOTA_FISCAL` INT NULL,
  `DATA_EMISSAO` DATE NULL,
  `DATA_VENCIMENTO` DATE NULL,
  `DATA_RECEBIMENTO` DATE NULL,
  `NUMERO_PARCELA` INT NULL,
  `NUMERO_TOTAL_PARCELAS` INT NULL,
  `VALOR_RECEBER` DECIMAL(18,2) NULL,
  `VALOR_DESCONTO` DECIMAL(18,2) NULL,
  `VALOR_JUROS` DECIMAL(18,2) NULL,
  `VALOR_TOTAL` DECIMAL(18,2) NULL,
  `OBSERVACAO` TEXT NULL,
  `CONTAS_RECEBER_STATUS_ID` INT NOT NULL,
  `CENTRO_CUSTO_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_CONTAS_RECEBER_CONTAS_RECEBER_STATUS1_idx` (`CONTAS_RECEBER_STATUS_ID` ASC),
  INDEX `fk_CONTAS_RECEBER_CENTRO_CUSTO1_idx` (`CENTRO_CUSTO_ID` ASC),
  CONSTRAINT `fk_CONTAS_RECEBER_CONTAS_RECEBER_STATUS1`
    FOREIGN KEY (`CONTAS_RECEBER_STATUS_ID`)
    REFERENCES `WD_ERP`.`CONTAS_RECEBER_STATUS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTAS_RECEBER_CENTRO_CUSTO1`
    FOREIGN KEY (`CENTRO_CUSTO_ID`)
    REFERENCES `WD_ERP`.`CENTRO_CUSTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`FLUXO_CAIXA_TIPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`FLUXO_CAIXA_TIPO` (
  `ID` INT NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`FLUXO_CAIXA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`FLUXO_CAIXA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DATA_MOVIMENTO` DATE NULL,
  `VALOR` DECIMAL(18,2) NULL,
  `SALDO` DECIMAL(18,2) NULL,
  `NUMERO_NOTA_FISCAL` DECIMAL(18,2) NULL,
  `FLUXO_CAIXA_TIPO_ID` INT NOT NULL,
  `CONTAS_PAGAR_ID` INT NOT NULL,
  `CONTAS_RECEBER_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_FLUXO_CAIXA_FLUXO_CAIXA_TIPO1_idx` (`FLUXO_CAIXA_TIPO_ID` ASC),
  INDEX `fk_FLUXO_CAIXA_CONTAS_PAGAR1_idx` (`CONTAS_PAGAR_ID` ASC),
  INDEX `fk_FLUXO_CAIXA_CONTAS_RECEBER1_idx` (`CONTAS_RECEBER_ID` ASC),
  CONSTRAINT `fk_FLUXO_CAIXA_FLUXO_CAIXA_TIPO1`
    FOREIGN KEY (`FLUXO_CAIXA_TIPO_ID`)
    REFERENCES `WD_ERP`.`FLUXO_CAIXA_TIPO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FLUXO_CAIXA_CONTAS_PAGAR1`
    FOREIGN KEY (`CONTAS_PAGAR_ID`)
    REFERENCES `WD_ERP`.`CONTAS_PAGAR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FLUXO_CAIXA_CONTAS_RECEBER1`
    FOREIGN KEY (`CONTAS_RECEBER_ID`)
    REFERENCES `WD_ERP`.`CONTAS_RECEBER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`NOTA_FISCAL_TIPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`NOTA_FISCAL_TIPO` (
  `ID` INT NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`NOTA_FISCAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`NOTA_FISCAL` (
  `NUMERO_NOTA_FISCAL` INT NOT NULL,
  `DATA_EMISSAO` DATE NULL,
  `NOTA_FISCAL_TIPO_ID` INT NOT NULL,
  `FLUXO_CAIXA_ID` INT NOT NULL,
  PRIMARY KEY (`NUMERO_NOTA_FISCAL`),
  INDEX `fk_NOTA_FISCAL_NOTA_FISCAL_TIPO1_idx` (`NOTA_FISCAL_TIPO_ID` ASC),
  INDEX `fk_NOTA_FISCAL_FLUXO_CAIXA1_idx` (`FLUXO_CAIXA_ID` ASC),
  CONSTRAINT `fk_NOTA_FISCAL_NOTA_FISCAL_TIPO1`
    FOREIGN KEY (`NOTA_FISCAL_TIPO_ID`)
    REFERENCES `WD_ERP`.`NOTA_FISCAL_TIPO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NOTA_FISCAL_FLUXO_CAIXA1`
    FOREIGN KEY (`FLUXO_CAIXA_ID`)
    REFERENCES `WD_ERP`.`FLUXO_CAIXA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`BANCO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`BANCO` (
  `CODIGO` INT NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  PRIMARY KEY (`CODIGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`AGENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`AGENCIA` (
  `CODIGO` INT NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  `BANCO_CODIGO` INT NOT NULL,
  PRIMARY KEY (`CODIGO`),
  INDEX `fk_AGENCIA_BANCO1_idx` (`BANCO_CODIGO` ASC),
  CONSTRAINT `fk_AGENCIA_BANCO1`
    FOREIGN KEY (`BANCO_CODIGO`)
    REFERENCES `WD_ERP`.`BANCO` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`ENTIDADE_CONTAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`ENTIDADE_CONTAS` (
  `ID` INT NOT NULL,
  `AGENCIA_CODIGO` INT NOT NULL,
  `ENTIDADE_ID` INT NOT NULL,
  `ENTIDADE_ENTIDADE_TIPO_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_ENTIDADE_CONTAS_AGENCIA1_idx` (`AGENCIA_CODIGO` ASC),
  INDEX `fk_ENTIDADE_CONTAS_ENTIDADE1_idx` (`ENTIDADE_ID` ASC, `ENTIDADE_ENTIDADE_TIPO_ID` ASC),
  CONSTRAINT `fk_ENTIDADE_CONTAS_AGENCIA1`
    FOREIGN KEY (`AGENCIA_CODIGO`)
    REFERENCES `WD_ERP`.`AGENCIA` (`CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENTIDADE_CONTAS_ENTIDADE1`
    FOREIGN KEY (`ENTIDADE_ID` , `ENTIDADE_ENTIDADE_TIPO_ID`)
    REFERENCES `WD_ERP`.`ENTIDADE` (`ID` , `ENTIDADE_TIPO_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WD_ERP`.`LOG_SISTEMAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WD_ERP`.`LOG_SISTEMAS` (
  `ID` INT NOT NULL,
  `DATA` DATETIME NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  `USUARIO_ID` INT NOT NULL,
  `USUARIO_GRUPO_USUARIO_ID` INT NOT NULL,
  `FUNCIONALIDADES_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_LOG_SISTEMAS_USUARIO1_idx` (`USUARIO_ID` ASC, `USUARIO_GRUPO_USUARIO_ID` ASC),
  INDEX `fk_LOG_SISTEMAS_FUNCIONALIDADES1_idx` (`FUNCIONALIDADES_ID` ASC),
  CONSTRAINT `fk_LOG_SISTEMAS_USUARIO1`
    FOREIGN KEY (`USUARIO_ID` , `USUARIO_GRUPO_USUARIO_ID`)
    REFERENCES `WD_ERP`.`USUARIO` (`ID` , `GRUPO_USUARIO_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LOG_SISTEMAS_FUNCIONALIDADES1`
    FOREIGN KEY (`FUNCIONALIDADES_ID`)
    REFERENCES `WD_ERP`.`FUNCIONALIDADES` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




------------------- TABELAS NOVAS TESTE PARA ACRESCENTAR NO SISTEMA


-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`TB_ENT_GRAOS` - Identificador da tabela ENGR
-- CONTROLE DE ENTREGA DE SOJA ARMAZEM
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`TB_ENT_GRAOS` (
  `CO_SEQ_ID_ENGR` INT NOT NULL AUTO_INCREMENT,
  `DT_ENT_ENGR` DATE NULL COMMENT'Data da entrega do produto',
  `NO_NUM_NT_ENGR` INT(9) NULL COMMENT'Número da nota',  
  `TP_COM_SEM_ENGR` VARCHAR(3) NULL COMMENT'COM - Com nota SEM - Sem nota',
  `NO_NOM_CAM_ENGR` VARCHAR(100) NULL COMMENT'nome do camioneiro',
  `DS_PLA_ENGR` VARCHAR(100) NULL COMMENT'Placa do caminhão',  
  `DS_DESC_ENGR` VARCHAR(100) NULL COMMENT'Descritivo',
  `NU_QTD_ENGR` DECIMAL(18,2) NULL,
  `FK_ID_ENGR` INT NOT NULL COMMENT'Tabela TB_PESS Nome do local da entrega';
  CONSTRAINT `FK_TB_PESS_ID`
    FOREIGN KEY (`FK_ID_ENGR`)
    REFERENCES `WDGESTOR`.`TB_PESS` (`CO_SEQ_ID_PESS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  CONSTRAINT `PK_TB_PESS_ID`
    PRIMARY KEY (`CO_SEQ_ID_ENGR`))
  
  -- Cadastro de entrada de grãos teste
  INSERT INTO TB_ENT_GRAOS (DT_ENT_ENGR, NU_QTD_ENGR, TP_COM_SEM_ENGR, NO_NOM_CAM_ENGR, DS_PLA_ENGR,  
        DS_DESC_ENGR, NU_QTD_ENGR, FK_ID_ENGR) 
        VALUES('2018-02-21', 2020, 'COM', 'Maicon', 'NFR6061', 'teste1', 42000, 1);
  INSERT INTO TB_ENT_GRAOS (DT_ENT_ENGR, NU_QTD_ENGR, TP_COM_SEM_ENGR, NO_NOM_CAM_ENGR, DS_PLA_ENGR,  
        DS_DESC_ENGR, NU_QTD_ENGR, FK_ID_ENGR) 
        VALUES('2018-02-22', 2026, 'SOM', 'Roberto', 'TFZ6061', 'teste1', 16170, 1);
  
  
-- -----------------------------------------------------
-- Tabela `WDGESTOR`.`TB_ENT_SAI_CC` - Identificador da tabela ENTSAI
-- CONTROLE FINANCEIRO CONTA CORRENTE ENTRADA E SAIDA DE VALORES
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDGESTOR`.`TB_ENT_SAI_CC` (
  `CO_SEQ_ID_ENTSAI` INT NOT NULL AUTO_INCREMENT,
  `DT_CAD_ENTSAI` DATE NOT NULL COMMENT'Data da entrega do produto',
  `DS_DESC_ENTSAI` VARCHAR(200) NOT NULL COMMENT'Descrição do produto entrante ou sainte',  
  `VL_ENT_ENTSAI` DECIMAL(10,2) NULL,  
  `VL_SAI_ENTSAI` DECIMAL(10,2) NULL,  
  `VL_SALDO_ENTSAI` DECIMAL(10,2) NULL COMMENT'Saldo',    
  PRIMARY KEY (`CO_SEQ_ID_ENTSAI`))

  -- Cadastro de valores de entrada e saida calculo
  INSERT INTO TB_ENT_GRAOS (DT_CAD_ENTSAI, DS_DESC_ENTSAI, VL_ENT_ENTSAI, VL_SAI_ENTSAI, VL_SALDO_ENTSAI) 
                     VALUES('2018-02-21', '');
  INSERT INTO TB_ENT_GRAOS (DT_ENT_ENGR, NU_QTD_ENGR) VALUES('2018-02-22', 10893);   
 
