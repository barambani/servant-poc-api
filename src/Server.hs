{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module Server (
  runningWebApp
) where

import Data.Proxy
import Servant.Server (serve)
import Servant ((:>), Get, JSON, Server, (:<|>)(..), Post, ReqBody, Handler)
import Network.Wai (Application)

import Types.Environment (Env(..), environment, unMkPort)
import Types.HealthCheck (Signature (..))
import Types.Prices (PricesRequestPayload, Price)
import Network.Wai.Handler.Warp (run)
import Data.Either (Either (..))

signature :: Signature
signature = Signature
  "servant-poc-api"
  "0.0.1.0"
  "lts-14.6 (ghc-8.6.5)"
  "now"

prices :: PricesRequestPayload -> Handler [Price]
prices = undefined

type Api =
  "pricing-api" :> "prices" :> ReqBody '[JSON] PricesRequestPayload :> Post '[JSON] [Price]
  :<|> "pricing-api" :> "health-check" :> Get '[JSON] Signature

server :: Server Api
server = prices
  :<|> pure signature

webApp :: Application
webApp = serve api server
  where api = Proxy :: Proxy Api

runningWebApp :: IO ()
runningWebApp = do
  Env{..} <- environment
  run (unMkPort port) webApp