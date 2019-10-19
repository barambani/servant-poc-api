{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Types.Prices (
  PricesRequestPayload,
  Price
) where

import Data.Aeson.Types (ToJSON, toJSON, FromJSON)
import Data.Text (Text)
import GHC.Generics (Generic)
import Data.Decimal

newtype ShowToJson a = ShowToJson a deriving Show
instance Show a => ToJSON (ShowToJson a) where
  toJSON = toJSON . show

newtype UserId         = UserId { unMkUserId :: Int } deriving (Eq, Show, Generic, FromJSON)
newtype Currency       = Currency { unMkCurrency :: Text } deriving (Eq, Show, Generic, ToJSON)
newtype ProductId      = ProductId { unMkProductId :: Int } deriving (Eq, Show, Generic, FromJSON)
newtype DiscountReason = DiscountReason { unMkDiscountReason :: Text } deriving (Eq, Show, Generic, ToJSON)

newtype DiscountAmount = DiscountAmount { unMkDiscountAmount :: Decimal }
  deriving (Eq, Show, Generic)
  deriving ToJSON via ShowToJson Decimal

newtype MoneyAmount = MoneyAmount { unMkMoneyAmount :: Decimal }
  deriving (Eq, Show, Generic)
  deriving ToJSON via ShowToJson Decimal

data PricesRequestPayload = PricesRequestPayload {
  user     :: UserId,
  products :: [ProductId]
} deriving (Eq, Show, Generic)
instance FromJSON PricesRequestPayload

data Discount = Discount {
  dAmount :: DiscountAmount,
  reason  :: DiscountReason
} deriving (Eq, Show, Generic)
instance ToJSON Discount

data Price = Price {
  pAmount  :: MoneyAmount,
  currency :: Currency,
  discount :: Maybe Discount
} deriving (Eq, Show, Generic)
instance ToJSON Price
