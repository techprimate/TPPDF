//
//  PDFTableContent+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TPPDF

class PDFTableContent_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableContent") {

            context("Equatable") {

                var content: PDFTableContent!

                beforeEach {
                    content = PDFTableContent(type: .none, content: nil)
                }

                it("is equal") {
                    let otherContent = PDFTableContent(type: .none, content: nil)
                    expect(content) == otherContent
                }

                it("is not equal with different type") {
                    let otherContent = PDFTableContent(type: .string, content: nil)
                    expect(content) != otherContent
                }

                it("is not equal with different strings") {
                    content.type = .string
                    content.content = "EXAMPLE"
                    let otherContent = PDFTableContent(type: .string, content: "INVALID")
                    expect(content) != otherContent
                }

                it("is not equal with different attributed strings") {
                    content.type = .attributedString
                    content.content = NSAttributedString(string: "EXAMPLE")

                    let otherContent = PDFTableContent(type: .attributedString, content: NSAttributedString(string: "INVALID"))
                    expect(content) != otherContent
                }

                it("is not equal with different images") {
                    content.type = .image
                    content.content = Image()

                    let base64Data = """
iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAAG0OVFdAAAAAXNSR0IArs4c6QAAAIRlWElmTU0AKgAAAAgABQESAAMAAAABAAEAAAEaAAUAAAABAAAASgEbAAUAAAABAAAAUgEoAAMAAAABAAIAAIdpAAQAAAABAAAAWgAAAAAAAABIAAAAAQAAAEgAAAABAAOgAQADAAAAAQABAACgAgAEAAAAAQAAAICgAwAEAAAAAQAAAIAAAAAAu7RpdAAAAAlwSFlzAAALEwAACxMBAJqcGAAAAVlpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iPgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KTMInWQAAKIJJREFUeAHtfQl4HcWV7rmSLGuzJFubZWHLu+VVNl5YTMhCCCGECXlsSYgHHMIWAnjmxQSYvEwmE+B7IY8lPMIWXmBg8sBAMmFCVuLwwCwBvO+LvGFbtiTLsiXbsmT5zv9Xd93bt9Wl293SvRYPl93qvlWnTp1z6tSpU9VV1ZGJL+6MSi9CVtfxrl5kF8k6cfxEAoLNXx+d8Js/3qw7KN94Z3+3eEZkdXUlImDksc7EuE+MKZJlpxVI7fPbmJwQMk6ABefF1LOe2yIDB2TELgopPztDll1enQDLfBmkwHkRQdRFVQRxGZGIFOcNkLr54xPgIcREcolgX0eXDPvZWmFGlr7nW5PV79LMiKy6YZI483iyQNKKoydkT2uH5J/oksj9K+Qr5dkStWvMybInC2SpEVRINCqbvz1NZgzMkJ9cOjbGmpPlbtVIFljCJ4uy5W2wF/nBexL9wRziSqBAFIOqGrsrEktY3NwuLXfMJj4VMu56R2qGDFDPTNcBMjiBEuMXE4aiuObvzpITuOur654zQYGV0QnvrcpdEJwuwnGPIp7Bqf5ZJxzkaNgN3ztLPybcN9rxzjzd9GDNtuaETF4/nHoQyfjOYupK6BDpX/bAyxaQtzHPbZUMA5MJqqxhaA/01Y7nOhgZp/o6nxMak0bgtAU5sAsMSy+rlhI0MGdD4rMnBRqR8z44f4C8f8142XGsK4GabnrATLQFQ9D2m7uiyh6UZkRk/4mo7LppkixAs36h4VgMtycLJG0NDAcNCW3A6hsnKdKZi9bKyYYnCxRS2QMr5ARK3fPtqaq0IYoWPJ5INIEJrVFB4s+Tc8ulHC1x7APLBaZQhYjdEkVREG+9MOvd7cE1i3fLwYOd0nU3GhUw3Pj0Gln7jzNU044qCuJ5PC1S08KZkgHBMURByc+unqyeFRdA4OyMPO1BBKV62QOFBSwktQeZdulWsfG/iioI1mgP1myHLUjSuBvbOhL6hd7bg5oXdiQpM85CKp48KyEVBZlweroXGrhu3hj96Ove1NYps3+1E46AL3AF5KnHXtnH/mKzXFySbVTP+/+uWkoLBsgKuDDTPfwgL5yM810FbLGtHcdVy+yOLK5GRblZsm3+uBjI+J9vkPZ4cixeP3j2qzrRee+ELflDU9wMOtOyIfLhj61LaEElqIfl19XIpm/WyD+8XCcvNnrnzWCrNl3OQjTMkktHSjmKevbccjlm5z3a2SWn50RkF8zucTvuhNPG0X4Zykmwpk6fxWmvSIhOO+PfN0t9+3E5Z8IQqYXbVg9zXYAC3mzpUB7YXvym46D9IOa1+oC4Bda4eO+xFTCzDsdhAynWZpgy2uLKB1fKfnS47DM231qrwZTFLoOEoujNYkFZ8LhHF4vHA1pB3LQ7E9zPhNuHyP/4wnD55JRy5XO7YfibvvgvAHPNK9vjyaoP8i7HtwQoxkr00zf9bqcIL4Qi/H7vaJfkQDLjBkSkw2aazGfRFvA37lYfZpCA09EjUlOgwm1s8eaiHZlWOzOiD5wwODseE+vCulsoNENvpPHc1lMmkMhR2AE/AQRECjPjkOyEmd8jeLpFHnDS9i9zvaJ9xUWpuNonceWIZN3+V4e6ulLT8NO3EqaKll6PD3pLWBbr52SGrBPQ0JMZTr4ETFWwBXY+On+sb+GMxyguTGVm6JG8+666Nt/Fi6z/2ijZ0o7JHxihIJe5Chy9GYeZ3Y1onDpyzpFk17VjZdQzdYIuwncwE+BoHblPbJJ55QOlFP2/V2jqOCH/dtkoEIkOCUqdo4dkXsCuOBBgaAXOeNjxO88uk4lVBa7siT9Z7rorR6nIH7++R/7vXnZTPQc0Q4PqoC5jAc+3v14vFTmUQHf51qPuX73KckQ5Fme496Jq+fTa/fKNtxuNUwyEy+Lw0TM4CcPzP51ZJmeOKfYENUV+bnKJvFeVL3MWbfMg28rlSwc4qr7sz3tEeHmE3e0npEpJJ574GAj+4vQyGVacI/lg8rCBT3MVuCTAqqLw6fVUwt1pcrQSEjguO1M2gZB4OY4n5HWii5MJF45K6HURaSwgN2H2wCFpau2Um8YPknp6vnbeanD/129MxCxpZyzOaUdo7DSs+w4CmNj9ciLgzAhhKuD33TQqTxowRo/eOlX2HmKBUWkHsR24ot+dLgX0iBHnEAVQWfm9yjETQCQ6QNw680v1R+Wq2RUqJXrX6fIvU4rlOGAP2+7alhaLqAQKkK7zu+9mU+wkAEqkzStbzexfbpGDRzoVETd8ZoQ0LaiVwQWWE/rMJ8sVrLNxsVCd3333LQFaO019JrCPeHSN7Gg8rGUUu48YkmNVgaMOdD6vu5mABCU8IVMxAt116zTZf/i4DALyXHB14bMbZdOe1ljhfPhw/1GLAEcNehWs4/yZYijhLkzlD79/uUS/H59Mpzg5EnKGq84ZLve+1wgViFNgKaETKv5s1gEHAjZiFtaJa/SPP5A/LqtXGPRsGtMYIne+LY/8caus3+8aivegA/4sIRAUoYBcMovCbvvzLhnw2i45ClNRB92YlZcprWgpE4oHyCOrmmXwoCyXBNgKSGL34I8AIH/mohFyLgalfkLmwrcSwKz6ToiK/TCbYqephQQ+/fwWkc7NsYw9PZQVJUpAVaFZAoYUKF4soEW8fuU4OXeqZYBi8YaHjAVvJFYBGKAUvIK5O7YVS2XC86ee24TB6QYvHN3ihpVYPkEsgabYu3z4AwbKxFEF0Z9+KoYrzEM4HTARFoICtgCT52WWAJqcnzdZfuhRPaWhCk7+8NwkGj+c9QWMuRX0BXYfOCI1i07u+wIfNKYUxNwIUlps/0F+SgBhjAAH/xuP+JteDVrX0+DZcAyX6OUFxeIfHkbI0ef7zLcRg8PoN/3PHflEq8DoW25pbJcJv98tIzEDH2SmJUg5GjZcE3A6ShoT7oa+zgGR/JEe/vjyXOn6+zHSCXck5+ebZRS0IlUaYXZHe6LV4Sc5wTIeXo+lV5mSh0i8PgscmuHhR79Vo/JRENmo/parx8jE57fKQNfQJzByQ4aQGmCoazA9HWr79GeGytThBd3GawYakkYfg8B1U2CDLcIk2REDCUmRuQDCCcDkW8OB3Y8pm+mv7sKCK1AYlMjDXRK9w1qvQjpZ6XwH3XTthASyGf/UW/XyyKZWNUcVQtli+MIJwNAEOJ9VEsmUfz9vqJwzbnBs7UystJAPXtp/7dxKmX/2UFm7q02mQeDDaDBD4M86EaIXMI6wgWsfXmue+6fdeKcKLQgTvLjVeKh5aAsvzy2TS2ZYL42nDh8kXTfUyB2/2SavNLRLW0CtC6cBprEaNCOCtGFssLrR2sRzbrunDrcFzG2fN17Kn9ggNQWZcsgTOCJcWJqN2nYGGsxOaB99GlPrdMI7n40zY9Yo1hrLu5+do2UnMk4+OGH5RmEP37AgvhDPC8cWSDloV4S6YItQc+c8u0l2XjNO1t8wWaoxB10Abpz41LPJtgCfu/xueV1lMj2DxAS9WJBncOFq4TvqQ8dl181TZF3bcXl6c6u8ctloWfn1cVLfejwmCF3+QTA34nFr3uOtb06SVddPknp7TjQmNFXF3ctnNBnSuPzew2mASc9AgFPqFFT5oEypfWS1/O78Sll242ThGpuK+1bB2k+XvbdMlbGYcx2K9qHzVcKPaDxkzSxmZ2XIkZsny171MsBijnCevQu1hZeLhmS/Q7nCELOnAjDey7Wux0z61/HarPnPu6WRi4t+OEvlX7HjoLx5wxTVbrfsbZPxT21Uq03KCgfG8Ofi1cs8rBl740AH+n4yz/bfXQPAucW8qXJiGBMf+twIqhpKLEP9ohEsRT819sl1chCv9ZpumQZniZbB6u/HVeLdyvdmqt/OPxwbXDuzVJa9tlsOs3bBv+ebPVXz5uk/J07nc0hX2KQB8N1B8AVlOVKemyn31rXJaXit5PTa2FcPwUaF0Y+vwagvKkv+bqScOaHESVPCM+t75YetalzAdq0GBR4KQDWi8AkSJITUAEMRKP0wDNnLe49KAShfdsVomT7KcojeXNcov1rRJIvRV1MbPjs0R66cWSGzxllrlMmoV+CK3ls/P1pue/tvUlyQZbUAzyaA3EoIXljMceHm5EzOk7IBVhXQIfn0ojoZhu7sXGjEY1jLPLemNLa+2UmSiXkNo4zbD8+QyP94VyqLMOvtUcsxA+iRpvF43UNqgKEU1D5X4Oj3RixwT2dUnt9zRH55z3tyGqz6ehizS0fkyYJzh8nk6mIpwqt9OjLt6B221bfJD363XRbhRegINCE6R2S2ZmCmLDwLb2ZgO6L61Q9JcEoO2qcsPvMkJJAKc4ANMLRncx56Mt6piKfz8o3RBVJTkYuxgJPCxCw7G48IL3f4Uk2R8HIHtWcpLwNMGspWwrK6Sk8VcSO0f/etBqAWisDzF7BE4ayaMkORvYjG+mzhkhlVyy48iLMWAbjik/wMJwC6o14B8U1wff9tyW5ZsrbJHg2atcALhXdcVAZkgHGMEYxmnkJRzcAbgyk2XDeIgjwD4kvA79Vzq+TMiX2vAQtee12iFXCSvDRAMc8m4EmZMTJkL2AQQEZUGqEFX3yBb3L9vc01UuaRUFqabS1L9khTXSCbgYE0ryyMQxMIKDLmMuSJPvgppp6cEGsCwSQQ2gaoVsBC+6KJ94HIYn6AqXkayohkfff1YCIDIurMSNeEhwF/2qIb0PQ4hgzKTCgNYKXvCCjptEkiYEHhjGDAQvozeDhPsD9zFJC2k75/ICC9fQ5+qgkENpt9XgcnF+EpDfCcXzu5lZLW0jHHlNby+l1hp5pA0NETFYZTVfuxTaLPA975jccuiHQ6mWgCwdpAPuYlLi8bKPd+rqrP+SfCyFNbZCqEcDQYWaFpwQg+2D/WDndqpCpEsQ1tO/AP4sxXGv5lUAGCXBZwqti38B7CeQ6jMfc3hJOqAekLwgthMc0aogRS5REY25vLifIlHF5wQVm25KdYAugFnMUmf1bgHnm4pE29wgaKoHMkRMc8WZhjcB7N8q+fO00WPVuHPWbWOQbJqQsOEbgbtASQKAG+wPzNqv2ycOUB1X5LwU2QPoLMl6MHeP68SpmCLYd8UaJDQSQqB4E/sUSd2vt7nzlCXLUyGFczKL0GW16dW6/8kJkFBDl4c9RNf8h5qrgH6lAa4Ok+s5ZA6CEcMnHfF6v98OwLhs3qOBCjhakwEELuwBNF1RchsB+gCiWnXoHxfdxFLr58ZIIGsAsuf3qLDMfy2b4QQmAjaFm4eBvVctAiGYMlLpGH1+lo/3cYwGUXVUntiEEJNqA4N3EPlPINbpkkkQfXyki8KO2tvIM3AXLqpQGIY9NoQOO/vionprJ+JYB1FMLlMO7gsIcqiW+eWXx0wWSJPLRWxkHgPZ1e5Mbn/h3cCKqq1vXtQofoVix3ffz60a6Evv2phRK9DUL42XqZgoVWB4N0Ow5yArvCygCa+FdVY0h0FNrbR2cJ0W9NVLu7c9FdhvkXuAko4smoO9jMj6INeADn/HQ3E+4c3r919bpTdZlYdxj9/oyE1NeungC7s0aqsPYoaAjeBHoqAXLhSQNVWN0RJFCcTfhTA0PYBKvWk+x2Hye0R2C0IckDOhYFL9MyXkHvMQyOh6A4NDy7oomQ2f1YBN0CI8p+X6e5754GmDT0kMeNw/k78GgQ5XgHO57p+lI1gt/FUOs9x8hYPE3D8M549u/DcQTApq+OlX09wBpr2YDbWY7Xc7jRIDF1C4hjp2yXQoa4UJpLZjZgAdRaODQNWCClHA8XJawRHi86AVtjqiAEbpBoQF61Od8Fa+z43XA+fwdvAmTcwL+ywiiYDBWC8duxGmx2YZZMxVK5yc9skeg/zZAP4SpzzOBUQ/1M147n9xRj5dgHFw8XDqp0mr4rAXcTPmkyNxud1+seuAkoArwEYAtGC57LWn+P5W7f+USl3MMlbtz59QAWSX+nVubgtINKDH40rL5PwcFEv1/ZoNYWzRxdLDXoUXIt3mKwnsJ3la3x+bmHawKeVMTVX9cGV3lPe6FOzp9aKgdxCK7gyN2HX9shv/jaBLlrVokMAJ4uB5VtMICL1h2IucIvXT1RtmFtYIx7DUuG3UGnBbwH1gDi98G/ohm+iZTAvc2+d4UUYvNT9I4Z8oftbbJhd6tcgmWyb1w5RprQJDjSI166tM83c6wXD5+HtvCYFs2XZ9kEt3FoOL/3PtQAB5WO0nnwy3DsGYjct5xkyqvfnCw7cd7KYWjD8JI86bp9ujQd7JBBkBZrYyQnFuxAI3j3Z6qUPYlJgLi9AuNDXCFcYZTuSQMjlRns9rcdhI3HJOdZj8JDRPjslDIZkAnZ41kNbr4/S0bnZMpwGMtrqvMUH4TjzNC06iJZyyWy9r9YIgESgoYIdle9UgKeZD9sn7sbmKMCuqUh4gD0HINX+fJTa+XX106WXKz/jde1yJ+unyLvbNwvoyvyE7JznlDQTKJZOByFwVP4iMdgyKQcKp/hT7gm4EGEiupBBdkFNcAobsaRxBc9sTqBeU3bGeOHSAVOAes2HHD4F0Yueyhb5TGk950RJBeQwgBcLMvk9e1FwlZsvR/z4ArNd+zunAyNRfLBxkm8Rg1wwBh49ZQDBIA2E+BSWLyosHHU49ynv+CcvxZY80o4Nuzm3PgboQkRLLaM/Ov7CXwaf9BS2Xis8j0gPcrReXq6W5ZISzbpnWJmLfCPR0B8IQzZ9Mc2SPTuM+Sh86qkBYec5QC8DMKgU5OF5xzcOdFVineAkTve9UDkioL9iPkLbA5egTQxKeAVeD7AxLuiCYVn4qrAJzNi3+CYVi77WtrlP96vl1frDslyzBjNzM+SL00okv82Z5jaMOHFj47jrPDqa2vkspfqMN0G5GTQKzCpR+K8MqFCjLXpDc9SrMudjnhFAO6cEzgNmxsi3/+bRLHVpRTb4K777Ei54fy43Wcf79xZ4kanf/Ow/inoCjc2H5OiQm6XMcx9mejSiAx3tC7gDHDFgA0INS7uGSrl7NBd78qe5qOqTyeNOtDgdbP2dqIaBWpA3KkF9+N4zzI6SQ4cDhAVr8sOcg/eBFAq6jqh7NgPcOhUQ+yXlDx4gWf9HLO3GAy9ct1UGYRpbs2g8xsPVgXCGwSTS7c0y5xnsdwe22YFzeXQd2bIjOpCyVrXgsL9lR2jKclDwCkxFm6oBafYHYXS2FEb1qPtF+JUQDo1j36iQi6oLZfKklwcTZuJ12h4/3e4Q15buU+u/O0umTgkG2MHTBHlWnN8hXf+Tf7zqtF2E3Mgdz4qCToj/D0H14B4M3aVYNU+p7OGw3vzqqdiqjBeZjy1ulmewOF/61HD7TRsiB6HCc3ByDdhsKUh7EL1zGpV5UD5yp92oRkhyqQBKsmrVOIxh8ACUJyZiEA8Bzk//OwwtdPTXGywFDarDfuOyv/Z2iqtprKhRc7m57eEgE0AaE0EUPi8oOqXf6I61s79EtITHI3gEuw8fXFbm1WGFzDpCq4AId4OK0a9SrJrgCqNYHRrvYhPEpeBpsGPIymvDcLwDBBAKA0wVahnIRSx2r7tStU04V5GJ2jhm2i+RmPhyuzzJ14e5pj2DBIFSdN0+ERJsBCOELO5SlLGidHYNQbD9iC+wtSpNlb1hRBYsyJbDxyTl/ccNb8IJVAICQQ2gqoMF/+WPBiJC6cu33bJBNDiBqLgwgVq/ZI1+2TxK9uk0YQXMGHKhAACEkV4Qx6Fy7YBPe0bDliiOpBmIPyFmNvqhQCFB+YFeDDNYuDGqxAV5yEBW9MzgWtYKWzAt//a9zYATlG+eudooFdxb0gz8sLRacA8nvA2Dlp+zumWlMbPAOmh7FBJh01mBTR40paklBBGEBS4SqL/ftk51epKUl7qkkmTiy4/hQU2gqrFhCjIDzG9ggFNaTOCAVtNr/jynTmcAgT3A1Tl448e0vomMFWAujZImCIuWEGBjWAnOuUmnLS/bvuBYCWlGhp2KAT/EnjzNI0wV2tybW9/Cjvgf4ShKHAvQI3jS8ydpkHJSZJKGOZJauAmcJL4S1mxwbvBlJFychBbk24np+x+UerHXgM+9gKITFy0U7sS/UIlTxGRXgl87FtAesXd/0o7pQD9r07SStHH3gtKq7T7YWGnLEA/rJR0kgQFSGdxp8rqbxIIPBcUlgHqGdf5FsQm0RgTdgYnLBV+8lktgmvXuDi71bAczQ+mjwJMWroAbGmVdVgcPA/nYd88fTDmrfu3aEgeP25Uh0+nXrH0gEzCUlbq6jEk9EeV7Y0009IFqP2jmK6uwMqO2dgW3+81wJbo9NNwdMv0Eln+YZuc/tpeKYdSVOI6BEUgT/1cj33pRVq6ACUo29mweoCPVjuqxXku0fljZRdW51z+h92yEms8Z2GjC7c3K+X2Jer+CRRqnwjrMshlvUhnk/lothmuemAYVpQt73x1tBzCYt1Z2Ae7HYpQgjSuBQoij/4EmxYfwPocDqWk5PiR/aMVIR+LmR+9eIQ8An4efrNeFuCrUZOxetP5BZmPCpNp6QLiK0p71gAutODiqlfX7JdbP2iW2dhkgeMD0h64CHU5drP9+vxhMmlYvloA4lzuy2dyQsNw9ewy+eWH+EQIFoUWIJ+9MjDtNIctMC1OoFqvpOyePzKP2dsJaV5b7H52AyWbLmXg/Ghbl/pqn5FiagAUgJ2DOlMSv7VpN+bphwkh1oaG4ILConR89wGARcV3Ig+/UbUcH+dbcTEP1irs1hpDUBM4i7P1e2Xmwn2ui+XiXXLpFdKlu15l9xSXHgtACigck3TcFBJOXVjtaOfVa5DUsnu1TNqdqe9/O7ex9YQdWyJlALbRZ6FrcG6PIu3ZiFmLvcHsG2rRtzTjkQamv4S0OIGK2aD2EfDMQivAsdbmhqPqhMl2CDPVAkQ9qk1eYyrypDiPJ5t0nwAiDAO/g/y3eWOtHz385V7n+xfvltvXHlIjCLXttwf4dCWlxwlkT0kp+gwKFAKL4GpD06/G9qBbVxyQpuUHYhMwlH8AlL5KJk6a6pHQsC3wAVZcOsJSANKia9wXpu5AtBILzzsNl8hLSxvk8jcbZSqGkhw5dBB/9yxpiUlTFwAuwaTvGrNheRsMwa/EB3n/euEw+dSEwapl2sPylAoIRWNjjlUtyXwAP4Ro/SHeS08vk+jMcnlnS4uc/fs9UoWugQeHtyIx1dbNTWtaugAybSmAenLT4P0btc/Rg6oCfQckf2themfsm1iWQw+EStgXgd4B6Vb82AycMbpIorcUS13DEfn0b3bIbnyKcxLmGA7YI5++KDcZDnQByUD6KD1IOYSl5PG/g3/QLHZgGnbLviPqK9V90SL9cIVznUJt9+V8hj5Fm3XNM9YrMYtYjlMzyJZWYD2xNLI0V3ZeN1GaWjvk8pe2yRacnleFdw7Qh5SHfmoBwDndfkjrEO6VMJE/WtksOasOsE1CKKod9bFwLLzEz/6aLwB5+l/QkjR1Ol8h+qu30YX99jND5aJamH78ozVwBn14fklBttTCL3i9tVN9TZTHrqQ6pEUBlMqjMoPywxy6G6CzdCSGISim5GIkRn4pZTPm9388uUiyUXEL3m+WiTi7ghXBT7wjOVAgTpUHE1t+Nu/Fugi7FD95AhHkARzwyChgIFeBL2RQefjHR9Cw6g543Gk6e7qIlRV1FG58LhoYJw57gnensYw2ZJqKjci3Y8TRCRsevaNWFl00XPYDuB72eDCUAnXpG29cTsjkN9iEqcpnthRfabEA5CkmNV+CQAa7C/BqBapfBUg+KpqouVCD55DRifrptGLZBn/hgU14h4/WyxOng7TcJsBPxNfsF65uUX33nReOlAM3TZbmtg6Zh2O71rQcxwIRvAqGsvh5FRzj3RffBAIzMSXwnSk0YOzoAQoyVVcMsavvS0a1koODrhg8CG3BtXBSsZyGt3B7cbJmEVrneHjQty47IIfwBqljYa0srB0i+3DmOhUlj1bBRpCMT3rhU/Ky5K5VLfLc23tULp79+uo1E2XnvHGyDk4aaeNKJxMuZmJaAgB/Jws2QjfvpnJ6G48uAChSfFnmzC4nmQCYrrjqThfx8OKZVDxy/eYlDbKgdrBE/3utXDUyXzbhgO4xORFZjbNos//nCqkqzpbondPlN1+qVh/mboCilMMcxE4g7IHvJnQBk3Da2by3GmTjnlZ86YifeouqA76jt0yVn2Bp2w6cisLTENV2cReuGM9khmmWOiTn3oUn1XUT+NxMXQlB7oprzVhyEVgQlBmE5lUOZwj3YUp4BE5Wnv9uowz636tl/txKid41Q1798ijJxRAKk/Ny7h93y7znNsio8jzZcNMUab9tqnwVitJ4sFNKUXE8zc3rXE9dJvt7hkXLGtWd3juHoDy+6u/PqZKlV46S1TgWUyuBzue+WwqgUCT9Y7FNvqk33vz3ZXx6nEDVnyfl3QEA7nUeSsRwHQMMj2QZg/oue3itPLp4p0wYViCvXzdZogvR8s8pl+f2tkve3SvktTWNMhBfq1p4wUicZH+6PHl+lXwIi9AIv6HUdu7c5RxGP58HO//SzsNy8EinHsyocw2pBKePKpb3rhgpaw90qiMDWGluHAm/HRwaH2M48BB7ToK3F3BpsQDUWFuljXwnJCiG/Gk/jyevhzUYisUjP117QCL3LJOlW60DLC6cXo4T+6fLYXQDS3e2SuRHS6WxlZ+hF+EJ/Uw7eOMkOR8fydwPcz4UVoFr5GjSSTOtwxDArsIpgO04EdgZOIlDuNljBsuTc0vhHHZICX0CO6/zrnhXtenEYHhGfi0rJ45UPad5TaCBaa9oW6sd8tBy8bxz2NeIOhoNRZj16x1S8tBKmHqrsrPR8m+/cLREvzdTjqAyH/nLDumAI8eQn5MlD1wxXqXdd+5QqcdKIFoFHgJCL38X+oGLBw2IH/CLStZBT+hccnoFvMws9SEQtSYgXodWK7aK0tmS3x35/fIfFi49TiC1Xx34i7ufEJIbanMrTPNgtOQKVFTVk+vlwifWSFv7cWW+abary/Lk5vOqVcV3wHLoWTiSdR7O9Y/eebq03TJF5o8bJLuxEEXgL9w8q1Sd7sr8jvqPdQk8GPmesQWy78hxfOzAVHt+GAcMeUc5nloeUi494cI8gE/CQoEROe0iGbN48oNGkQTCtNkLOvXLltuIllsER/DDo8dl8EOr5BJ85fIXX52gvlDDiqQJp2VwBj03n5edJf9wwSj5x8+PkiMw/TkYajLodGceUAkOI8Kl47K0WQbAApFui2bygEfy4szU07OGx13lVTmdatdT5uBpOMvdN2nBsRM1PzihmAqY3c7DvKSRZzOxF6Znrl+mJMPIrWj70DcU4l3CJhxuNfinq+Qc7E568WvjZSi+08Dzmp0WQONz4ucnDv2IvwDzBAyKXtKuLAEjGMsQe7B+Gv9qOLtmNC4jfO8S0tIFKN5jkvFDMLi24bkepxlj8nMx5OMqmmZU5DA0SHxoRQ3HNJzpztZIHBw20iI0wAeofHytRH68VDbuPqSIoUUwBT+Vz7wtmClUppvMal55529l0k0luOJVFuJgVt5Te6XWCbR5sJjhDxezpp+KeQu8HQ5UDUz1C9uOyGMzhuBLirPliS+MkFlwzA5gDL4fDttQmPMiGmLk45pBk8zYNXAKl7OGIzBXcOGiOon88H35w4p9Ko+JnJ7iOS9AX+LRD5qglZnSAhOlyMcf3mO894TEnca8YELxQRTqd2ruaVkSFlXmkK6wEombXe/fdBrBORdZsuUPKcyUB/FK+MY39skbXxktv8J3CBgo/OV1B+SVVU1yDw5WF7x6VWfsorXDvqvXcQWopDZKkSQAni/aD+LnRJxw/dCcEpmG1cY0+wRxmn9VQJI/zENf4rc3TJVrn1krz+Bg52p0OVzdg/8KZygHmLmJIMUhrU5gIIaUvlAIbFE0xBjvQxFOw6cHvvzbHbIfCyc+uGqszBwzRGaNHSJz8P2lu121145vOB7DcI8mnn09z13m+evOYDlsVowruxPM+Kzz0BI8PX+KlD+/Xu7b1CqjaA206Q9UkRbP8Y9iMbPfjshIpjEBXQBNTaou1p+F224KRkISEpBHVbwtCwuH5VdxkSgasAzDio3LXt6qPs/y7Bs7Y7rFymZ2BlZ4Ib5WUpyfrb5a4q58wqil37oWGeEjkB5OAulLl8es//zlcfJJvIXchp1C/ACgIowANk2M6ikoXApc10lchlqWfXlPSxdgbQ3zLwQlICU0Swhu/WcbthaI4Fsk6Bp+srRR5r+xVzWURfhux0UzKyVvYJZqN3hvp9D1ZhmZHjYSERv1jobDsgcfQ6SFofc/srxAff2N6fko97tnV8j/e3G7DCnByyibD6b5ChqeZCtt8JUrNFCKuwCbLsWMpcm+KbXzsP74aApUhl0wCYV4FUwn75+X7JMrFtcrX2BWxUAcSFEic2uGSDUqyT3uN+F0xnNhyOrtLfL02/XyMNb0c63YWCwaoYtBuqic/FDktv2dctmYfHnh+lopxF4C5W9owlV35sSa5Jn5cKWh/nlarqYyCVG9SA7bCrSp81s05wm4AKQQWnGiKEt2YMh37/uN0vVeo9ThWTikgB8hcNJGYtHHVFxDUZn5tl/QBrO9Dy+I3oUj2Yh3AwoWffkELAA5CjkVwNpQ4RqgFM5AJSgqzpL/bDomc/7XB1JIfHiVzO9GlvHNpJKxLWfemMEUCKu6MWvNgQmsr+LTsypYf2/GloGReKdw+IyLEz/8NvVerNVTFcgaYJqPgG8NifUi1wWMBSPbOzplezMq2V0ZGrduGPga0kZcfsNSAkJhKmAp+OEwRavG6QeJhtV5/eTpBUxaLIBqAc5WYCJYVwaZZ2eLPNWw6+sbO+Tt62rkrJpSU85+Ff/OhiY5+8kNMrEsWzmKwWw5+WbrD3cEflBBpHYq2KaGzMSVwA+JlvrDBVR6wBmeY3C4GI7D/HrNyfvBmmoYOotcOaRoBc0cJajAu37WSm4ixmId8Pxv5zfB9kF8eroAMu2HF8JoAdmOE/cFYImP/GVNkzQeaFcTPwFHbX0gJn8oWMd0NFftRucDmg/B3+C+gATenTya0BJGXyaYPopPbxegW4Ef4u1W08JZQLjcP+IXRFdioYdWED84TgYMKw70DoEjSNrpv8Ravx96FN/p7AJIcIqD1QX4KERXrtZ+3KvxaeoNDR2y5IYamTup3AeSkw/y1roGOefxDVJTDh+A5ASVsQ0fpL2E5TpNE0EUArhKJgimKyUgrHWxB2DGTs7hIygfoJ/2Aezz6QNYtMIHsIiP8aIYSPbH5tuXvJLh8pGepi4AlGjGeiJKWwDCAJ7/jrDesdR7WV0LvtMeVbNvvZnV66n43qZRAfhd6GVbDyqaubeQ280sT9Yndi0npf9K+31mDAeWHieQfPjhhTBQAsqAkzB8tbuXEwFYlPGTFftlEL49TX1w6gl+9ptAslnfXJZGmkn7KHRhVADFk19KkV3BE2GKQ5osgM1REino4d1Fc6qkqbYi1NbsFMsrFHpahly8I2DQPBoRUUZUIDUXYITqswQoQJ/hMiLSTqDfsiisXKzL+/8q+DVbjllTv/LqjZzS5ATaFsBXP2CbeL8C6w33/TKvLSvWfhoaZ1osgGKEzKSBoX5ZpwGIsl6cWT5AWixAOqYbVZtGv+ZahR1ALB8f0Cw1c6jXQKW+xUQG3PF6ykuh556LiwcwqDV7H5/6DM4plrwV4BXyUeTkiCLVIS1dALvzdlzU7ijW5Z8KZgkoWaGd8J7yloky0jMMNPN7KsUlgXRUurPI9EwEOUs89dyvJHDKAvSr6kg/MacUIP0y71clnuoC+lV1pJ+YUxYg/TLvVyX+F6HKI6BucPebAAAAAElFTkSuQmCC
"""
                    let data = Data(base64Encoded: base64Data)!
                    let otherContent = PDFTableContent(type: .image, content: Image(data: data)!)
                    expect(content) != otherContent
                }

                it("is not equal with different content nil") {
                    content.type = .image
                    content.content = Image()

                    var otherContent = PDFTableContent(type: .image, content: nil)
                    expect(content) != otherContent

                    content.type = .image
                    content.content = nil

                    otherContent = PDFTableContent(type: .image, content: Image())
                    expect(content) != otherContent
                }

                it("ignores content if unknown objects") {
                    content.type = .image
                    content.content = ["RANDOM"]

                    let otherContent = PDFTableContent(type: .image, content: ["RANDOM"])
                    expect(content) == otherContent
                }
            }
        }
    }

}
