{-# LANGUAGE OverloadedStrings #-}

module Api (
  signature,
  prices
) where

import Servant (Handler)
import Types.HealthCheck (Signature (..))
import Types.Prices (PricesRequestPayload, Price)

signature :: Signature
signature = Signature
  "servant-poc-api"
  "0.0.1.0"
  "lts-14.6 (ghc-8.6.5)"
  "now"

prices :: PricesRequestPayload -> Handler [Price]
prices = undefined
