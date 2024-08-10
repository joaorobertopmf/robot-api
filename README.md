
# Projeto de Automação de Testes de API com Robot Framework

Bem-vindo ao repositório de automação de testes API! Este projeto utiliza o [Robot Framework](https://robotframework.org/) para a criação e execução de testes automatizados. O objetivo é garantir a qualidade e a integridade do software testado de maneira eficiente e automatizada.

## Estrutura do Projeto

A estrutura do repositório é organizada da seguinte forma:

```plaintext
├── Libraries/                    # Bibliotecas criadas em python  
├── Resources/                    # Arquivos de recursos contendo variáveis e keywords utilizadas ao longo do projeto 
├── Results/                      # Armazena os relatórios e logs das execuções dos testes
├── Tests/                        # Pasta raiz de todos os testes  
│   └── Auth                      # Contém testes relacionados ao login
│   └── Company                   # Contém testes relacionados a empresa
└── README.md                     # Documentação do projeto

```

## Pré-requisitos

Antes de executar os testes, certifique-se de ter as seguintes ferramentas instaladas:

- Python 3.6+
- Robot Framework
- RequestLibrary (para testes de API)

Você pode instalar todas as dependências utilizando o arquivo `requirements.txt`:

```bash
pip install -r requirements.txt
```

## Executando os Testes

Para executar os testes, utilize o seguinte comando na raiz do projeto:

```bash
robot -d reports/ testes/
```

Isso irá executar todos os testes na pasta `testes/` e salvar os relatórios de execução na pasta `reports/`.

### Executando Testes Específicos

Caso queira executar um teste específico, utilize o comando abaixo:

```bash
robot -d reports/ testes/nome_do_teste.robot
```

### Variáveis de Ambiente

Você pode definir variáveis de ambiente para personalizar a execução dos testes. Isso pode ser feito diretamente no terminal ou em arquivos `.env`:

```bash
export BROWSER=chrome
export ENVIRONMENT=staging
```

## Integração Contínua (CI)

O projeto inclui um pipeline de integração contínua configurado com GitHub Actions. O arquivo de workflow está localizado em `.github/workflows/web-ci.yml` e é executado automaticamente a cada novo commit ou pull request.

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues, sugerir melhorias ou enviar pull requests.

## Licença

Este projeto é licenciado sob a [MIT License](LICENSE).

---

**Desenvolvido com ❤️ por [Seu Nome]**
