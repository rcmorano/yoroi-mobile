// @flow
import React from 'react'
import {compose} from 'redux'
import {View, Image, FlatList, StatusBar} from 'react-native'
import {withTranslations} from '../../utils/renderUtils'

import styles from './styles/LanguagePicker.style'
import koreanFlagIcon from '../../assets/img/flags/korean.png'
import japaneseFlagIcon from '../../assets/img/flags/japanese.png'
import russianFlagIcon from '../../assets/img/flags/russian.png'
import englishFlagIcon from '../../assets/img/flags/english.png'
import chineseFlagIcon from '../../assets/img/flags/chinese.png'
import selectLanguageImage from '../../assets/img/select_language.png'
import LanguageListItem from './LanguageListItem'
import l10n, {LANGUAGES} from '../../l10n'
import {Button} from '../UiKit'

import type {SubTranslation} from '../../l10n/typeHelpers'

const supportedLangauages = () => [
  {
    label: l10n.translations.global.language.chineseSimplified,
    code: LANGUAGES.CHINESE_SIMPLIFIED,
    icon: chineseFlagIcon,
  },
  {
    label: l10n.translations.global.language.chineseTraditional,
    code: LANGUAGES.CHINESE_TRADITIONAL,
    icon: chineseFlagIcon,
  },
  {
    label: l10n.translations.global.language.english,
    code: LANGUAGES.ENGLISH,
    icon: englishFlagIcon,
  },
  {
    label: l10n.translations.global.language.japanese,
    code: LANGUAGES.JAPANESE,
    icon: japaneseFlagIcon,
  },
  {
    label: l10n.translations.global.language.korean,
    code: LANGUAGES.KOREAN,
    icon: koreanFlagIcon,
  },
  {
    label: l10n.translations.global.language.russian,
    code: LANGUAGES.RUSSIAN,
    icon: russianFlagIcon,
  },
]

const getTranslations = (state) => state.trans.LanguagePicker

type Props = {
  changeLanguage: (string) => any,
  handleContinue: () => mixed,
  languageCode: string,
  translations: SubTranslation<typeof getTranslations>,
}

export const LanguagePicker = ({
  changeLanguage,
  languageCode,
  handleContinue,
  translations,
}: Props) => (
  <View style={styles.container}>
    <StatusBar barStyle="dark-content" backgroundColor="#fff" />
    <FlatList
      style={styles.list}
      contentContainerStyle={styles.listContainer}
      data={supportedLangauages()}
      keyExtractor={({code}) => code}
      extraData={languageCode}
      renderItem={({item: {label, code, icon}}) => (
        <LanguageListItem
          label={label}
          iconSource={icon}
          selectLanguage={changeLanguage}
          isSelected={languageCode === code}
          languageCode={code}
        />
      )}
    />

    <Image source={selectLanguageImage} style={styles.image} />
    <Button onPress={handleContinue} title={translations.continue} />
  </View>
)

export default compose(withTranslations(getTranslations))(LanguagePicker)