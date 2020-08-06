module CONSTANT
	POSTAL_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}/
	PHONE_NUMBER_REGEX = /\A^0\d{9,10}$\z/
	FULL_WIDTH_REGEX = /\A[ぁ-んァ-ンー-龥]/
	FULL_WIDTH_KATAKANA_REGEX = /\A[ァ-ヶー－]+\z/
end