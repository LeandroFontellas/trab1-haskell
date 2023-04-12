module Main (main) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

main :: IO()
main = do 
    hSetBuffering stdout NoBuffering
    putStrLn "==============================="
    putStrLn "Banco Leandro Fontellas Laurito"
    putStrLn "==============================="
    putStrLn "Opções:"
    putStrLn "1. Saldo"
    putStrLn "2. Extrato"
    putStrLn "3. Depósito"
    putStrLn "4. Saque"
    putStrLn "5. Fim"
    putStrLn "Escolha uma opção:"
    opcao <- getLine
    case opcao of
      "1" -> do imprime "saldo.txt"; main
      "2" -> do imprime "extrato.txt"; main
      "3" -> do 
              valor <- getLine
              deposito (read valor)
              main
      "4" -> do 
              valor <- getLine
              saque (read valor)
              main
      "5" -> putStrLn "Obrigado por usar o banco"
      _ -> do putStrLn "\nOpção inválida, tente novamente!\n"; main

imprime :: String -> IO()
imprime path = do 
  conteudo <- readFile path
  putStrLn conteudo

deposito :: Float -> IO()
deposito valor = do
  conteudo <- readFile "saldo.txt"
  putStrLn conteudo -- Evita a Exception: openFile: resource busy
  writeFile "saldo.txt" (deposita (read conteudo) valor)
  appendFile "extrato.txt" ("+" ++ show valor)
  where
    deposita:: Float -> Float -> String
    deposita saldo valor = show (saldo + valor)

saque :: Float -> IO()
saque valor = do
  conteudo <- readFile "saldo.txt"
  putStrLn conteudo -- Evita a Exception: openFile: resource busy
  writeFile "saldo.txt" (withdraw (read conteudo) valor)
  appendFile "extrato.txt" ("-" ++ show valor)
  where
    withdraw:: Float -> Float -> String
    withdraw saldo valor = show (saldo - valor)

