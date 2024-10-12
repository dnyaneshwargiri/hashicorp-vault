import "reflect-metadata";
import { DataSource } from "typeorm";
import * as dotenv from "dotenv";

dotenv.config();
const dataSource = new DataSource({
  type: "postgres",
  host: process.env.POSTGRES_HOST,
  port: parseInt(process.env.POSTGRES_PORT as string, 10),
  username: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB,
  entities: [],
  synchronize: true,
  logging: false,
});

console.log("process.env.POSTGRES_PASSWORD", process.env.POSTGRES_PASSWORD);
console.log("process.env.POSTGRES_DB", process.env.POSTGRES_DB);
console.log("process.env.POSTGRES_USER", process.env.POSTGRES_USER);
console.log("process.env.POSTGRES_HOST", process.env.POSTGRES_HOST);
console.log("process.env.POSTGRES_PORT", process.env.POSTGRES_PORT);

export const dbConnection = async () => {
  dataSource
    .initialize()
    .then(() => {
      console.log(
        `Successfully connected to Postgress Database running on:${process.env.POSTGRES_HOST}`
      );
    })
    .catch((error) => {
      console.log(`Oh shit! Something fucked up: ${error}`);
    });
};

export const closeDataSource = async () => {
  try {
    await dataSource.destroy();
    console.log("Data Source has been closed!");
  } catch (error) {
    console.error("Error during Data Source closure:", error);
  }
};
