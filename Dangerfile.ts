import commitlint from 'danger-plugin-conventional-commitlint';
import configConventional from '@commitlint/config-conventional';

export default async () => {
  const commitlintConfig = {
    severity: 'warn'
  };
  await commitlint(configConventional.rules, commitlintConfig);
}
