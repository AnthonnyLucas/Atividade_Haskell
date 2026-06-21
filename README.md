# Atividade de Haskell — Tipos, Funções, Recursão e Listas Infinitas

Este repositório contém a resolução de uma atividade acadêmica sobre os fundamentos da linguagem **Haskell**, abordando inferência de tipos, funções polimórficas, recursão, currying, aplicação parcial e avaliação preguiçosa (*lazy evaluation*).

## 🎯 Objetivo do projeto

O objetivo desta atividade é praticar conceitos introdutórios de **programação funcional** usando Haskell, especificamente:

- Como o Haskell **infere e checa tipos** de expressões (e por que algumas expressões geram erro de tipo).
- Como escrever **funções simples** com assinaturas de tipo explícitas.
- Como funciona a **recursão** em listas.
- Como definir **listas infinitas** aproveitando a avaliação preguiçosa do Haskell.
- Como interpretar os tipos de **funções polimórficas e de ordem superior** (`const`, `(++)`, `map`), incluindo os efeitos da **aplicação parcial** (currying).

Este projeto foi desenvolvido como entrega de atividade de disciplina e serve tanto como resolução dos exercícios quanto como material de apoio para apresentação/explicação dos resultados.

## 📁 Estrutura do repositório

```
.
├── exercicios.hs      # Código-fonte em Haskell com a resolução de todas as questões
├── explicacao.md       # Explicação detalhada do raciocínio, tipos e resultados de cada questão
├── como-rodar.md        # Guia rápido de execução (resumo do passo a passo)
└── README.md            # Este arquivo
```

- **`exercicios.hs`** → contém as funções implementadas e uma função `main` que executa e imprime os resultados de todas as questões no terminal.
- **`explicacao.md`** → explica, em português, o porquê de cada tipo e resultado — útil para estudar e apresentar a atividade.
- **`como-rodar.md`** → guia objetivo de como rodar o projeto, focado no dia a dia (uso do GHCi, comando `:t`, etc).

## ✅ Pré-requisitos

- Sistema operacional **Windows** (este guia é específico para Windows; os comandos do Haskell em si funcionam igual em outros sistemas, mas a instalação muda).
- **VS Code** instalado — [baixar aqui](https://code.visualstudio.com/)
- Conexão estável com a internet (a instalação do GHC baixa ~200-300MB)

## 🛠️ Passo a passo de instalação (Windows)

### 1. Instalar o GHCup (instalador oficial do Haskell)

1. Abra o **PowerShell** (não precisa ser administrador).
2. Cole o comando abaixo e aperte Enter:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; try { & ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -Interactive -DisableCurl } catch { Write-Error $_ }
   ```
3. O instalador vai fazer algumas perguntas. Responda assim:

   | Pergunta | Resposta recomendada |
   |---|---|
   | `Install HLS (Haskell Language Server)?` | **Y** (sim — necessário para autocompletar e checagem de erros no VS Code) |
   | `Install stack?` | **N** (não é necessário para esta atividade) |
   | `Create Desktop shortcuts?` | **Y** ou Enter (padrão) — não afeta o funcionamento |

4. Aguarde a instalação. Pode demorar de 5 a 15 minutos.

> ⚠️ **Erro comum:** `ERROR: The certificate of 'www.haskell.org' is not trusted.`
> Isso geralmente acontece por relógio do Windows desatualizado ou instabilidade momentânea de rede. **Solução:**
> 1. Verifique se a data/hora do Windows está correta e com atualização automática ativada.
> 2. Feche o PowerShell, abra um novo e rode o comando do passo 2 novamente. Na maioria dos casos, funciona na segunda tentativa.

> ⚠️ **Erro comum:** `"ghcup --metadata-fetching-mode=Strict --cache install ghc recommended" failed!`
> O GHCup em si pode já ter sido instalado com sucesso, mas o download do GHC falhou no meio do processo (geralmente por instabilidade de internet/antivírus). **Solução:** abra um **novo** PowerShell e rode manualmente:
> ```powershell
> ghcup install ghc recommended
> ```

### 2. Verificar se o GHC foi reconhecido pelo terminal

Feche **todas** as janelas do PowerShell/terminal abertas e abra uma nova (isso é necessário para o Windows recarregar a variável de ambiente PATH). Depois rode:

```powershell
ghc --version
ghci --version
```

> ⚠️ **Erro comum:** `ghc : O termo 'ghc' não é reconhecido...` mesmo depois de reabrir o terminal.
> **Causa real:** às vezes a instalação do GHC fica "pela metade" e não chega a configurá-lo como a versão **padrão** ativa — faltando o arquivo `ghc.exe` genérico (você só vê `ghc-9.10.3.exe`, por exemplo, mas não `ghc.exe`).
> **Solução:** descubra a versão instalada e defina ela como padrão manualmente:
> ```powershell
> ghcup set ghc 9.10.3
> ```
> (troque `9.10.3` pela versão que aparecer ao rodar `ghcup list` ou que você viu instalada). Depois disso, `ghc --version` deve funcionar normalmente.

### 3. Instalar a extensão Haskell no VS Code

1. Abra o VS Code.
2. Vá em **Extensões** (`Ctrl+Shift+X`).
3. Pesquise **"Haskell"** e instale a extensão publicada por **haskell.haskell**.
4. Na primeira vez que abrir um arquivo `.hs`, a extensão pode pedir para instalar o **HLS** automaticamente — aceite e aguarde (pode demorar alguns minutos).

### 4. Abrir o projeto

1. Baixe/clone este repositório.
2. No VS Code: **File > Open Folder...** → selecione a pasta do projeto (onde está o `exercicios.hs`).

### 5. Executar o programa

Abra o terminal integrado do VS Code (`` Ctrl+` ``) e rode:

```powershell
runghc exercicios.hs
```

Isso vai compilar e executar o arquivo, mostrando no terminal os resultados organizados de todas as questões.

> ⚠️ **Erro comum:** `Couldn't match expected type 'Bool' with actual type 'Char'` ao rodar.
> O arquivo `exercicios.hs` contém, **propositalmente comentadas**, duas linhas que geram erro de tipo (são exemplos das questões 1.3 e 8.6, que pedem justamente para identificar expressões inválidas). Se você (ou a extensão do VS Code) acabar **descomentando** essas linhas sem querer, o arquivo inteiro deixa de compilar. As linhas são:
> ```haskell
> -- exemplo1_3 = [True, False, 'a']
> -- exemplo8_6 = append [3] ['a', 'b']
> ```
> **Solução:** verifique se essas duas linhas estão comentadas (com `--` no início) e salve o arquivo antes de rodar novamente.

### 6. (Opcional) Explorar interativamente com o GHCi

Para testar funções individualmente e checar tipos com o comando `:t` (muito útil para as questões 1 e 8), use:

```powershell
ghci exercicios.hs
```

Veja o arquivo `como-rodar.md` para mais exemplos de uso do GHCi.

## 📖 Entendendo os resultados

Toda a explicação detalhada — o porquê de cada tipo, cada erro e cada resultado — está no arquivo [`explicacao.md`](./explicacao.md). 

## 📝 Licença / Uso

Projeto de uso acadêmico, desenvolvido como resolução de atividade da disciplina de Paradigmas de Programação.
