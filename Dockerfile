# Use a imagem base do Maven para compilar o projeto
FROM maven:3.8.5-openjdk-17 AS build

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo pom.xml e as dependências para dentro do contêiner
COPY cadastro/pom.xml .

# Baixa as dependências do projeto
RUN mvn dependency:go-offline

# Copia o código-fonte para dentro do contêiner
COPY /cadastro/src ./src

# Compila o projeto e gera o arquivo JAR
RUN mvn clean package -DskipTests

# Usa uma imagem base menor para rodar a aplicação
FROM openjdk:17-jdk-slim

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o JAR gerado no estágio anterior
COPY --from=build /app/target/cadastro-0.0.1-SNAPSHOT.jar ./cadastro-0.0.1-SNAPSHOT.jar


# Expõe a porta em que a aplicação será executada
EXPOSE 5000

# Define o comando para rodar a aplicação
CMD ["java", "-jar", "cadastro-0.0.1-SNAPSHOT.jar"]
