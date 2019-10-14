{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Types (
  Signature,
  signature
) where

import Data.Text
import GHC.Generics
import Data.Aeson.Types (ToJSON)

data Signature = Signature {
  name           :: Text,
  version        :: Text,
  haskellVersion :: Text,
  buildTime      :: Text
} deriving (Eq, Show, Generic)
instance ToJSON Signature

signature :: Signature
signature = Signature
  "servant-poc-api"
  "0.0.1.0"
  "lts-14.6 (ghc-8.6.5)"
  "now"