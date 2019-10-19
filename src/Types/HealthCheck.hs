{-# LANGUAGE DeriveGeneric #-}

module Types.HealthCheck (
  Signature (..)
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

