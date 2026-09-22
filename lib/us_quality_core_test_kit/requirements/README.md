# Requirements inventory and coverage

All 13 US Quality Core 1.0.0-ballot summary requirements are included.
Maintain IDs, wording, conformance verbs, source links, actor applicability, and
reasons for leaving requirements unverified directly in
`us_quality_core_test_kit_requirements.csv`, keeping them aligned with the IG.

To generate the requirements coverage reports, from the repository root:

```sh
bundle exec rake usqualitycore:generate mode=server
bundle exec inferno requirements coverage us_quality_core_v100_ballot
bundle exec inferno requirements check_coverage us_quality_core_v100_ballot
```
